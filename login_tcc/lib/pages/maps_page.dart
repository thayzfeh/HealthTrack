import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:login_tcc/components/buttons.dart';
import 'package:login_tcc/components/colors.dart';

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
        toolbarHeight: MediaQuery.of(context).size.height * 0.005,
        shadowColor: ColorStyle.background,
        backgroundColor: ColorStyle.background,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
              color: ColorStyle.background,
              height: MediaQuery.of(context).size.height * 0.068,
              child: const RetroButton(path: "/connection")),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    keepAlive: true,
                    initialCenter: _currentLocation,
                    initialZoom: 16.0,
                    onPositionChanged: (MapCamera position, bool gesture) {
                      if (gesture) {
                        _zoomLevel = _mapController.camera.zoom;
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      tileProvider: CancellableNetworkTileProvider(),
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          child: const Icon(
                            Icons.my_location_sharp,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          width: 40.0,
                          height: 40.0,
                          point: _currentLocation,
                          rotate: true,
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Checkbox(
                        value: isTrackingEnabled,
                        onChanged: (newValue) {
                          setState(() {
                            isTrackingEnabled = newValue!;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      right: 20,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () {
                          _zoomLevel++;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.background,
                        ),
                        child: const Text('+',
                            style: TextStyle(
                                color: ColorStyle.white, fontSize: 25)),
                      ),
                    ),
                    Positioned(
                      bottom: 95,
                      right: 20,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          _zoomLevel--;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.background,
                        ),
                        child: const Text('-',
                            style: TextStyle(
                                color: ColorStyle.white, fontSize: 25)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
