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

class MapsControllerImpl extends BaseController<BaseState> with ChangeNotifier {
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
  }) : super(InitialState());

  void getCurrentLocalization() async {
    final result = await getCurrentLocalizationUsecase();

    final newState = result.fold(
      (coordinates) {
        final marker = Marker(
          markerId: MarkerId('placed_location'),
          position: LatLng(coordinates.latitude, coordinates.longitude),
        );
        markers[MarkerId('placed_location')] = marker;

        return LoadedMapsState(currentCoordinatesEntity: coordinates);
      },
      (error) {
        return LocalizationDeniedState(reason: error.message);
      },
    );

    update(newState);
    notifyListeners();
  }

  void searchPostalCode(String cep) async {
    update(LoadingState());
    notifyListeners();

    final result = await searchPostalCodeUsecase(cep);
    final newState = result.fold(
      (data) {
        return SearchResultState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
    notifyListeners();
  }

  Future<void> searchCoordinates(
    double latitude,
    double longitude, {
    required void Function(LocationEntity) onComplete,
  }) async {
    final result = await searchCoordinatesUsecase(
      CoordinatesModel(latitude: latitude, longitude: longitude),
    );

    final newState = result.fold(
      (location) {
        final latlong = LatLng(
            location.coordinates.latitude, location.coordinates.longitude);
        final cameraUpdate = CameraUpdate.newLatLng(latlong);
        final marker = Marker(
          markerId: MarkerId('placed_location'),
          position: LatLng(
              location.coordinates.latitude, location.coordinates.longitude),
        );
        markers[MarkerId('placed_location')] = marker;
        googleMaps.animateCamera(cameraUpdate);

        onComplete(location);

        return LoadedMapsState(currentCoordinatesEntity: location.coordinates);
      },
      (error) {
        print('Erro ao buscar localização: ${error.message}');
        return ErrorState(error);
      },
    );

    update(newState);
    notifyListeners();
  }

  @override
  void dispose() {
    googleMaps.dispose();
    super.dispose();
  }
}
