import 'package:desafio_konsi/app/core/entities/entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';

class LocationEntity extends Entity {
  final String postalCode;
  final String state;
  final String city;
  final String neighbourhood;
  final String street;
  final CoordinatesEntity coordinates;

  LocationEntity(
    super.id, {
    required this.postalCode,
    required this.state,
    required this.city,
    required this.neighbourhood,
    required this.street,
    required this.coordinates,
  });
}
