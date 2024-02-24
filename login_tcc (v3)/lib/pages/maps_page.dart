import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  LatLng _currentLocation =
      const LatLng(-22.9153, -47.0659); // Coordenadas iniciais
  final MapController _mapController =
      MapController(); // Adicione um MapController
  double _zoomLevel = 16.0; // Valor inicial do zoom
  bool isTrackingEnabled = true;

  // Método para atualizar as coordenadas
  void updateCoordinates(LatLng newCoordinates) {
    setState(() {
      _currentLocation = newCoordinates;
      if (isTrackingEnabled == true) {
        _mapController.move(newCoordinates, _zoomLevel);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Chama a função a cada segundo
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // Simule a obtenção de novas coordenadas (substitua por sua lógica real)
      LatLng newCoordinates = getNewCoordinatesFromServerOrDatabase();
      updateCoordinates(newCoordinates);
    });
  }

  // Simulação: Obtenha novas coordenadas do servidor ou banco de dados
  LatLng getNewCoordinatesFromServerOrDatabase() {
    // Substitua por sua lógica real para obter as coordenadas

    return LatLng(
      _currentLocation.latitude +
          0.000, // Altere para simular movimento vertical
      _currentLocation.longitude +
          0.000, // Altere para simular movimento horizontal
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Mapa'),
          centerTitle: true,
          toolbarHeight: 45,
        ),
        body: Center(
            child: Stack(alignment: Alignment.bottomCenter, children: [
          SizedBox(
              child: Stack(
            children: [
              // Gerador do mapa
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  keepAlive: true,
                  initialCenter: _currentLocation,
                  initialZoom: 16.0,
                  // Altera o valor do zoom com gesto pinça, anula o uso do Slider
                  onPositionChanged: (MapPosition position, bool gesture) {
                    if (gesture) {
                      // Verifica o valor do zoom
                      _zoomLevel = _mapController.camera.zoom;
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    // Melhora performance do mapa, reduzindo consumo
                    tileProvider: CancellableNetworkTileProvider(),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        // Marcador
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                        width: 40.0,
                        height: 40.0,
                        point: _currentLocation,
                      ),
                    ],
                  ),
                ],
              ),

              // Usado para ajustar a posição da CheckBox
              Positioned(
                top: 500, // Ajuste a posição vertical conforme necessário
                left: 320, // Ajuste a posição horizontal conforme necessário
                child: Checkbox(
                  value: isTrackingEnabled, // Defina o valor do CheckBox
                  onChanged: (newValue) {
                    setState(() {
                      isTrackingEnabled = newValue!;
                    });
                  },
                ),
              ),

              // Aumentar zoom botão
              Positioned(
                  top: 520, // Ajuste a posição vertical conforme necessário
                  left: 320, // Ajuste a posição horizontal conforme necessário
                  child: ElevatedButton(
                      onPressed: () {
                        _zoomLevel++;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffc6c6c6),
                      ),
                      child: const Text('+',
                          style: TextStyle(color: Colors.white)))),

              // Aumentar zoom botão
              Positioned(
                  top: 555, // Ajuste a posição vertical conforme necessário
                  left: 320, // Ajuste a posição horizontal conforme necessário
                  child: ElevatedButton(
                      onPressed: () {
                        _zoomLevel--;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffc6c6c6),
                      ),
                      child: const Text('-',
                          style: TextStyle(color: Colors.white))))
            ],
          )),
        ])));
  }
}
