import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/shell/maps/widgets/selected_point_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    controller.searchFocusNode.addListener(() {
      controller.isSearchFocused.value = controller.searchFocusNode.hasFocus;
    });
  }

  void listener() {
    // if (controller.state is MapsState && controller.state.latitude != null) {
    //   controller.googleMaps.animateCamera(cameraUpdate);
    // }
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              return Opacity(
                opacity: state is MapsState ? 1.0 : 0.0,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: const CameraPosition(
                    zoom: 2.0,
                    target: LatLng(-15.6000, -56.1000),
                  ),
                  onMapCreated: (passController) {
                    controller.googleMaps = passController;
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
                              extra: RevisionDto(
                                  location: location, type: RevisionType.add),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              if (state is! SearchResultState) {
                return const SizedBox.shrink();
              }

              final listLocationsEntity = (state).listLocationsEntity;

              return Opacity(
                opacity: 1.0,
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 150,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (sliverContext, index) {
                                final location = listLocationsEntity[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: AppColors.lowGreenColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: SvgPicture.asset(
                                                'assets/svgs/map-marker.svg'),
                                          ),
                                        ),
                                        title: Text(
                                          location.postalCode,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: AppColors.mainTextColor),
                                        ),
                                        subtitle: Text(
                                          '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  AppColors.secondaryTextColor),
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
                                                        location: location,
                                                        type: RevisionType.add),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      Container(
                                        height: 1,
                                        color: const Color(0xffCAC4D0),
                                      )
                                    ],
                                  ),
                                );
                              },
                              childCount: listLocationsEntity.length,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: FloatingActionButton(
                          shape: const CircleBorder(),
                          onPressed: () {
                            final location = listLocationsEntity.first;
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
                                        location: location,
                                        type: RevisionType.add),
                                  );
                                },
                              );
                            });
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              if (state is! LocalizationDeniedState) {
                return const SizedBox.shrink();
              }

              final reason = (state).reason;

              return Opacity(
                opacity: 1.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'O que aconteceu: $reason',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.getCurrentLocalization();
                        },
                        child: const Text('Solicitar novamente'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              if (state is! ErrorState) {
                return const SizedBox.shrink();
              }

              final exception = (state).exception;

              return Opacity(
                opacity: 1.0,
                child: Center(
                  child: Text(exception.message),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              return SafeArea(
                left: false,
                right: false,
                child: SearchWidget(
                  keyboardType: TextInputType.number,
                  focusNode: controller.searchFocusNode,
                  controller: controller.searchInput,
                  onSubmit: (value) {
                    controller.searchPostalCode(value);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
