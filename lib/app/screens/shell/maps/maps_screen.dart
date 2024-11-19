import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';
import 'package:desafio_konsi/app/screens/widgets/search_widget.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late final MapsControllerImpl controller;

  @override
  void initState() {
    super.initState();
    controller = sl<MapsControllerImpl>();
    controller.addListener(listener);
    controller.getCurrentLocalization();
  }

  void listener() {}

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, state, child) {
                  return switch (state) {
                    LoadingState() => const CircularProgressIndicator(),
                    LoadedMapsState(:final currentCoordinatesEntity) =>
                      FlutterMap(
                        mapController: controller.map,
                        options: MapOptions(
                          initialCenter: LatLng(
                            currentCoordinatesEntity.latitude,
                            currentCoordinatesEntity.longitude,
                          ),
                          initialZoom: 17.0,
                          onTap: (tapPosition, point) {
                            controller.searchCoordinates(
                                context, point.latitude, point.longitude);
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          // MarkerLayer(
                          //   markers: [

                          //   ],
                          // ),
                          if (controller.placedLocation != null)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                      controller.placedLocation!.latitude,
                                      controller.placedLocation!.longitude),
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
                    SearchResultState(:final listLocationsEntity) =>
                      CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 100,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final location = listLocationsEntity[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Text(location.id.toString()),
                                  ),
                                  title: Text(location.postalCode),
                                  subtitle: Text(
                                    '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
                                  ),
                                  onTap: () async {
                                    controller.searchCoordinates(
                                        context,
                                        location.coordinates.latitude,
                                        location.coordinates.longitude);
                                  },
                                );
                              },
                              childCount: listLocationsEntity.length,
                            ),
                          ),
                        ],
                      ),
                    LocalizationDeniedState(:final reason) => Column(
                        children: [
                          Text('O que aconteceu: $reason'),
                          ElevatedButton(
                              onPressed: () {
                                controller.getCurrentLocalization();
                              },
                              child: const Text('Solicitar novamente'))
                        ],
                      ),
                    ErrorState(:final exception) =>
                      Center(child: Text('Erro: $exception')),
                    _ => Center(child: Text('Estado desconhecido: $state')),
                  };
                }),
            ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, state, child) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SearchWidget(
                      controller: controller.searchInput,
                      onChanged: (value) {
                        //validar
                        controller.searchPostalCode(value);
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
