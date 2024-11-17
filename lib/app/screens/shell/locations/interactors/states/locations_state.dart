import 'package:desafio_konsi/app/core/states/base_state.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

class LoadedLocationsState extends BaseState {
  final List<LocationEntity>? listLocationsEntity;

  LoadedLocationsState({
    this.listLocationsEntity,
  });
}
