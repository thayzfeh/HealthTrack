import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng _currentLocation =
      const LatLng(-22.9153, -47.0659); // Coordenadas iniciais
  MapController _mapController = MapController(); // Adicione um MapController
  double _zoomLevel = 13.0; // Valor inicial do zoom

  // Método para atualizar as coordenadas
  void updateCoordinates(LatLng newCoordinates) {
    setState(() {
      _currentLocation = newCoordinates;
      _mapController.move(
          newCoordinates, _zoomLevel); // Atualize o zoom conforme necessário
    });
  }

  void updateZoom(double newZoom) {
    setState(() {
      _zoomLevel = newZoom;
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
    // Aqui, estou apenas retornando coordenadas aleatórias para fins de exemplo
    return LatLng(
      _currentLocation.latitude + 0.001,
      _currentLocation.longitude + 0.001,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(
          height: MediaQuery.of(context).size.height * 0.96, // 80% da tela
          width: MediaQuery.of(context).size.width,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              keepAlive: true,
              initialCenter: _currentLocation,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
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
          )),
      Container(
        height: MediaQuery.of(context).size.height * 0.04, // 80% da tela
        width: MediaQuery.of(context).size.width,
        child: Slider(
          value: _zoomLevel,
          min: 8.0,
          max: 18.0,
          divisions: 10,
          onChanged: (newZoom) => updateZoom(newZoom),
        ),
      ),
    ])));
  }
}
