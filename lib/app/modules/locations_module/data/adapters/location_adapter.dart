import 'package:desafio_konsi/app/modules/locations_module/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';

class LocationAdapter {
  static LocationEntity fromJson(Map<String, dynamic> data) {
    try {
      return LocationEntity(
        data['id'] ?? -1,
        cep: data['cep'] ?? '',
        address: data['address'] ?? '',
        addressNumber: data['addressNumber'] ?? '',
        complement: data['complement'] ?? '',
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static LocationEntity fromHive(Map<String, dynamic> data) {
    try {
      return LocationEntity(
        data['id'] ?? -1,
        cep: data['cep'] ?? '',
        address: data['address'] ?? '',
        addressNumber: data['addressNumber'] ?? '',
        complement: data['complement'] ?? '',
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static Map<String, dynamic> toHive(LocationEntity location) {
    return {
      'id': location.id,
      'cep': location.cep,
      'address': location.address,
      'addressNumber': location.addressNumber,
      'complement': location.complement,
    };
  }
}
