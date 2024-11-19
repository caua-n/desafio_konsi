import 'dart:async';

import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/models/coordinates_model.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_current_localization_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_coordinates_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_postal_code_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class MapsControllerImpl extends BaseController<BaseState> {
  final SearchPostalCodeUsecase searchPostalCodeUsecase;
  final SearchCoordinatesUsecase searchCoordinatesUsecase;
  final GetCurrentLocalizationUsecase getCurrentLocalizationUsecase;

  late GoogleMapController googleMaps;
  Map<MarkerId, Marker> markers = {};
  final FocusNode searchFocusNode = FocusNode();
  final ValueNotifier<bool> isSearchFocused = ValueNotifier(false);
  final TextEditingController searchInput = TextEditingController();

  MapsControllerImpl({
    required this.searchPostalCodeUsecase,
    required this.searchCoordinatesUsecase,
    required this.getCurrentLocalizationUsecase,
  }) : super(MapsState());

  void getCurrentLocalization() async {
    final result = await getCurrentLocalizationUsecase();

    final newState = result.fold(
      (coordinates) {
        final latitudeLongitude =
            LatLng(coordinates.latitude, coordinates.longitude);
        googleMaps
            .animateCamera(CameraUpdate.newLatLngZoom(latitudeLongitude, 17.0));
        return MapsState();
      },
      (error) {
        return LocalizationDeniedState(reason: error.message);
      },
    );

    update(newState);
  }

  Future<void> searchCoordinates(double latitude, double longitude,
      {required void Function(LocationEntity) onComplete}) async {
    searchFocusNode.unfocus();
    final result = await searchCoordinatesUsecase(
      CoordinatesModel(latitude: latitude, longitude: longitude),
    );

    final newState = result.fold(
      (location) {
        final latitudeLongitude = LatLng(
            location.coordinates.latitude, location.coordinates.longitude);
        final marker = Marker(
          markerId: const MarkerId('placed_location'),
          position: latitudeLongitude,
        );

        markers[const MarkerId('placed_location')] = marker;

        googleMaps
            .animateCamera(CameraUpdate.newLatLngZoom(latitudeLongitude, 17.0));

        onComplete(location);

        return MapsState();
      },
      (error) {
        print('Erro ao buscar localização: ${error.message}');
        return ErrorState(error);
      },
    );

    update(newState);
  }

  void searchPostalCode(String cep) async {
    final result = await searchPostalCodeUsecase(cep);
    final newState = result.fold(
      (data) {
        searchFocusNode.unfocus();
        return SearchResultState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    isSearchFocused.dispose();
    searchInput.dispose();
    super.dispose();
  }
}
