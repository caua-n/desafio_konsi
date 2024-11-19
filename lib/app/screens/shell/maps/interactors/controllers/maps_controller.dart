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
  final TextEditingController searchInput = TextEditingController();
  Map<MarkerId, Marker> markers = {};

  MapsControllerImpl({
    required this.searchPostalCodeUsecase,
    required this.searchCoordinatesUsecase,
    required this.getCurrentLocalizationUsecase,
  }) : super(MapsState(markers: {}));

  void getCurrentLocalization() async {
    final result = await getCurrentLocalizationUsecase();

    final newState = result.fold(
      (coordinates) {
        _updateMapLocation(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
          markerId: 'placed_location',
        );
        return MapsState(markers: markers);
      },
      (error) {
        return LocalizationDeniedState(reason: error.message);
      },
    );

    update(newState);
  }

  Future<void> searchCoordinates(double latitude, double longitude,
      {required void Function(LocationEntity) onComplete}) async {
    await Future.delayed(Duration(milliseconds: 1000));

    final result = await searchCoordinatesUsecase(
      CoordinatesModel(latitude: latitude, longitude: longitude),
    );

    final newState = result.fold(
      (location) {
        _updateMapLocation(
          latitude: location.coordinates.latitude,
          longitude: location.coordinates.longitude,
          markerId: 'placed_location',
        );

        onComplete(location);

        return MapsState(markers: markers);
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
        return SearchResultState(markers: markers, listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }

  Future<void> _updateMapLocation({
    required double latitude,
    required double longitude,
    required String markerId,
  }) async {
    final latitudeLongitude = LatLng(latitude, longitude);
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: latitudeLongitude,
    );

    markers[MarkerId(markerId)] = marker;
    await googleMaps
        .animateCamera(CameraUpdate.newLatLngZoom(latitudeLongitude, 17.0));
  }
}
