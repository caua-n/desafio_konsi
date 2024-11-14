import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/core/types/types.dart';

abstract class ILocationsRepository {
  Future<Output<LocationEntity>> addLocation();
  Future<Output<ListLocationsEntity>> getLocations();
}
