import 'package:desafio_konsi/app/core/types/types.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

abstract class ILocationsRepository {
  Future<Output<LocationEntity>> addLocation(
      LocationEntity selectedLocation, String number, String complement);
  Future<Output<List<LocationEntity>>> getLocations();
  Future<Output<List<LocationEntity>>> searchPostalCode(String cep);
  Future<Output<LocationEntity>> searchCoordinates(
    double lat,
    double long,
  );
}
