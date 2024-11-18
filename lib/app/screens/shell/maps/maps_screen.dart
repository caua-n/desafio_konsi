import 'dart:async';

import 'package:desafio_konsi/app/core/services/service_locator.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late final MapsControllerImpl controller;
  late final MapController mapController;
  final TextEditingController _input = TextEditingController();
  Timer? _debounceTimer;

  void _onTextChanged(String value) {
    // Cancelar o debounce anterior, se existir
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    // Configurar um novo debounce
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      controller.searchLocations(value);
    });
  }

  @override
  void initState() {
    super.initState();
    controller = sl<MapsControllerImpl>();
    controller.addListener(listener);
    mapController = MapController();
  }

  void listener() {}

  void moveTo(String latitude, String longitute) {
    final latLng = LatLng(
      double.parse(latitude),
      double.parse(longitute),
    );
    mapController.move(latLng, 15.0);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Screen'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _input,
            onChanged: _onTextChanged,
            decoration: InputDecoration(
              labelText: 'Digite algo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) {
                return switch (state) {
                  LoadedMapsState(:final listLocationsEntity) => SizedBox(
                      height: 100,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  childCount: listLocationsEntity!.length,
                                  (BuildContext context, int index) {
                            final location = listLocationsEntity[index];
                            return SizedBox(
                              height: 100,
                              child: ListTile(
                                title: Text(location.street),
                                onTap: () {
                                  moveTo(
                                    location.coordinates.latitude,
                                    location.coordinates.longitude,
                                  );
                                },
                              ),
                            );
                          }))
                        ],
                      ),
                    ),
                  ErrorState(:final exception) =>
                    Center(child: Text('Erro: $exception')),
                  _ => Center(child: Text('Estado desconhecido: $state')),
                };
              }),
          SizedBox(
            height: 300,
            child: FlutterMap(
              mapController: mapController,
              options: const MapOptions(
                initialCenter:
                    LatLng(51.509364, -0.128928), // Ponto inicial do mapa
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                RichAttributionWidget(
                  attributions: [
                    // TextSourceAttribution(
                    //   'OpenStreetMap contributors',
                    //   onTap: () => launchUrl(
                    //       Uri.parse('https://openstreetmap.org/copyright')),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
