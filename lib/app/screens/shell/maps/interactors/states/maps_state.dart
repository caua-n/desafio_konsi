import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/initial_coordinates_entity.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

class LoadedMapsState extends BaseState {
  final InitialCoordinatesEntity initialCoordinatesEntity;

  LoadedMapsState({
    required this.initialCoordinatesEntity,
  });
}

class SearchResultState extends BaseState {
  final List<LocationEntity> listLocationsEntity;

  SearchResultState({
    required this.listLocationsEntity,
  });
}
