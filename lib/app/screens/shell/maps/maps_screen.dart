import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/shell/maps/widgets/selected_point_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';
import 'package:desafio_konsi/app/screens/widgets/search_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                    // InitialState() => FlutterMap(
                    //     options: const MapOptions(
                    //       initialCenter: LatLng(-15.6000, -56.1000),
                    //       initialZoom: 4.0,
                    //     ),
                    //     children: [
                    //       TileLayer(
                    //         urlTemplate:
                    //             'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    //         userAgentPackageName: 'com.example.app',
                    //       ),
                    //     ],
                    //   ),
                    LoadedMapsState(:final currentCoordinatesEntity) =>
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            zoom: 17.0,
                            target: LatLng(currentCoordinatesEntity.latitude,
                                currentCoordinatesEntity.longitude)),
                        onMapCreated: (control) {
                          controller.googleMaps = control;
                        },
                        markers: controller.markers.values.toSet(),
                        onTap: (point) {
                          controller.searchCoordinates(
                            point.latitude,
                            point.longitude,
                            onComplete: (location) {
                              showSelectedPoint(
                                context,
                                location.postalCode,
                                '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
                                () {
                                  context.pushNamed(
                                    'revision',
                                    extra: RevisionDto(location: location),
                                  );
                                },
                              );
                            },
                          );
                        },
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
                              (sliverContext, index) {
                                final location = listLocationsEntity[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Text(location.id.toString()),
                                  ),
                                  title: Text(location.postalCode),
                                  subtitle: Text(
                                    '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
                                  ),
                                  onTap: () {
                                    controller.searchCoordinates(
                                      location.coordinates.latitude,
                                      location.coordinates.longitude,
                                      onComplete: (location) {
                                        showSelectedPoint(
                                          context,
                                          location.postalCode,
                                          '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
                                          () {
                                            context.pushNamed(
                                              'revision',
                                              extra: RevisionDto(
                                                  location: location),
                                            );
                                          },
                                        );
                                      },
                                    );
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
