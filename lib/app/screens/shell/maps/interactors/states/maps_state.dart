import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/list_locations_entity.dart';

class LoadedLocationsState extends BaseState {
  final ListLocationsEntity listLocationsEntity;

  LoadedLocationsState({
    required this.listLocationsEntity,
  });
}
