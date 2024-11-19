import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

enum RevisionType {
  add,
  update,
}

class RevisionDto {
  final RevisionType type;
  final LocationEntity location;

  RevisionDto({
    required this.type,
    required this.location,
  });
}
