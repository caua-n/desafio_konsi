import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/core/entities/entity.dart';

class ListLocationsEntity extends Entity {
  ListLocationsEntity(
    super.id, {
    required this.locations,
  });

  final List<LocationEntity> locations;
}
