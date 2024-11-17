import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

class LocationAdapter {
  static LocationEntity fromJson(Map<String, dynamic> data) {
    try {
      return LocationEntity(
        data['id'] ?? -1,
        cep: data['cep'] ?? '',
        address: data['logradouro'] ?? '',
        addressNumber: data['address_number'] ?? 0,
        complement: data['complemento'] ?? '',
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static Map<String, dynamic> toJson(LocationEntity entity) {
    return {
      'id': entity.id,
      'cep': entity.cep,
      'logradouro': entity.address,
      'address_number': entity.addressNumber,
      'complemento': entity.complement,
    };
  }
}
