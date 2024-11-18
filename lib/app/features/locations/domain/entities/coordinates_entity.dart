import 'package:desafio_konsi/app/core/entities/entity.dart';

class CoordinatesEntity extends Entity {
  final String longitude;
  final String latitude;

  CoordinatesEntity(
    super.id, {
    required this.longitude,
    required this.latitude,
  });
}