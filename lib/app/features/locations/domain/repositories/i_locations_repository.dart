import 'package:desafio_konsi/app/core/types/types.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

abstract class ILocationsRepository {
  Future<Output<LocationEntity>> addLocation();
  Future<Output<List<LocationEntity>>> getLocations();
}
