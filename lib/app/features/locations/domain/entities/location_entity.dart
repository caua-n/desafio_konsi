import 'package:desafio_konsi/app/core/entities/entity.dart';

class LocationEntity extends Entity {
  final String cep;
  final String address;
  final int addressNumber;
  final String complement;

  LocationEntity(
    super.id, {
    required this.cep,
    required this.address,
    required this.addressNumber,
    required this.complement,
  });
}
