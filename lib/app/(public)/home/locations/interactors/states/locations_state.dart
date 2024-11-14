import 'package:desafio_konsi/app/modules/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';

class LoadedLocationsState extends BaseState {
  final ListLocationsEntity listLocations;

  LoadedLocationsState({
    required this.listLocations,
  });
}
