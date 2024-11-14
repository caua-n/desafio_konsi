import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';

class LoadedLocationsState extends BaseState {
  final ListLocationsEntity listLocations;

  LoadedLocationsState({
    required this.listLocations,
  });
}
