import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

class MapsState extends BaseState {}

class SearchResultState extends BaseState {
  final List<LocationEntity> listLocationsEntity;

  SearchResultState({
    required this.listLocationsEntity,
  });
}

class LocalizationDeniedState extends BaseState {
  final String reason;

  LocalizationDeniedState({
    required this.reason,
  });
}
