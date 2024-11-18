import 'dart:async';

import 'package:desafio_konsi/app/core/services/service_locator.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';
import 'package:desafio_konsi/app/screens/shell/widgets/search_widget.dart';

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
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      controller.searchLocations(value);
    });
  }

  @override
  void initState() {
    super.initState();
    controller = sl<MapsControllerImpl>();
    controller.addListener(listener);
    controller.initializer();
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
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, state, child) {
            return switch (state) {
              LoadingState() => const CircularProgressIndicator(),
              LoadedMapsState(:final initialCoordinatesEntity) => Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SearchWidget(),
                    ),
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: LatLng(
                          initialCoordinatesEntity.latitude,
                          initialCoordinatesEntity.longitude,
                        ),
                        initialZoom: 17.0,
                        onTap: (tapPosition, point) {},
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                initialCoordinatesEntity.latitude,
                                initialCoordinatesEntity.longitude,
                              ),
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        const RichAttributionWidget(
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
                  ],
                ),
              ErrorState(:final exception) =>
                Center(child: Text('Erro: $exception')),
              _ => Center(child: Text('Estado desconhecido: $state')),
            };
          }),
    );
  }
}
