import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/models/coordinates_model.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_current_localization_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_coordinates_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_postal_code_usecase.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';
import 'package:desafio_konsi/app/screens/shell/maps/widgets/selected_point_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapsControllerImpl extends BaseController<BaseState> with ChangeNotifier {
  final SearchPostalCodeUsecase searchPostalCodeUsecase;
  final SearchCoordinatesUsecase searchCoordinatesUsecase;
  final GetCurrentLocalizationUsecase getCurrentLocalizationUsecase;
  final MapController map = MapController();
  final TextEditingController searchInput = TextEditingController();

  MapsControllerImpl({
    required this.searchPostalCodeUsecase,
    required this.searchCoordinatesUsecase,
    required this.getCurrentLocalizationUsecase,
  }) : super(InitialState());

  CoordinatesEntity? _placedLocation;
  CoordinatesEntity? get placedLocation => _placedLocation;

  void getCurrentLocalization() async {
    update(LoadingState());
    notifyListeners();

    final result = await getCurrentLocalizationUsecase();

    final newState = result.fold(
      (coordinates) {
        _placedLocation = coordinates;
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
      BuildContext context, double latitude, double longitude) async {
    final result = await searchCoordinatesUsecase(
      CoordinatesModel(latitude: latitude, longitude: longitude),
    );

    final newState = result.fold(
      (location) {
        final latlong = LatLng(
            location.coordinates.latitude, location.coordinates.longitude);
        map.moveAndRotate(latlong, 17.0, 0.0);
        _placedLocation = location.coordinates;

        showSelectedPoint(context, location.postalCode,
            '${location.street} - ${location.neighbourhood}, ${location.city} - ${location.state}',
            () {
          context.pushNamed(
            'revision',
            extra: RevisionDto(location: location),
          );
        });

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
    _placedLocation = null;

    map.dispose();

    super.dispose();
  }
}
