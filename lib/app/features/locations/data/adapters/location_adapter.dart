import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';

class LocationAdapter {
  static LocationEntity fromJson(Map<String, dynamic> data) {
    try {
      return LocationEntity(
        data['id'] ?? -1,
        cep: data['cep'] ?? '',
        address: data['address'] ?? '',
        addressNumber: data['addressNumber'] ?? '',
        complement: data['complement'],
      );
    } catch (e) {
      throw AdapterException(
        message: 'Erro ao adaptar JSON para LocationEntity: ${e.toString()}',
      );
    }
  }

  static Map<String, dynamic> toJson(LocationEntity entity) {
    try {
      return {
        'id': entity.id,
        'cep': entity.cep,
        'address': entity.address,
        'addressNumber': entity.addressNumber,
        'complement': entity.complement,
      };
    } catch (e) {
      throw AdapterException(
        message: 'Erro ao adaptar LocationEntity para JSON: ${e.toString()}',
      );
    }
  }
}
