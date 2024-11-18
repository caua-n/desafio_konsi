import 'package:desafio_konsi/app/core/entities/entity.dart';

class InitialCoordinatesEntity extends Entity {
  final double longitude;
  final double latitude;

  InitialCoordinatesEntity(
    super.id, {
    required this.latitude,
    required this.longitude,
  });
}
