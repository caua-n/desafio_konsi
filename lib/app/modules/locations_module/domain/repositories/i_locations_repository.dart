import 'package:desafio_konsi/app/modules/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/modules/locations_module/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/core/types/types.dart';

abstract class ILocationsRepository {
  Future<Output<LocationEntity>> addLocation();
  Future<Output<ListLocationsEntity>> getLocations();
}
