import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/coordinates_adapter.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

class LocationAdapter {
  static LocationEntity fromJson(Map<String, dynamic> data) {
    try {
      return LocationEntity(
        data['id'] ?? -1,
        cep: data['cep'] ?? '',
        state: data['state'] ?? '',
        city: data['city'] ?? '',
        neighbourhood: data['neighbourhood'] ?? '',
        street: data['street'] ?? '',
        // Extrai o campo 'location' e passa o subcampo 'coordinates' para o CoordinatesAdapter
        coordinates:
            data['location'] != null && data['location']['coordinates'] != null
                ? CoordinatesAdapter.fromJson(data['location']['coordinates'])
                : throw AdapterException(
                    message: 'Campo location ou coordinates está ausente'),
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static Map<String, dynamic> toJson(LocationEntity entity) {
    return {
      'id': entity.id,
      'cep': entity.cep,
      'state': entity.state,
      'city': entity.city,
      'neighbourhood': entity.neighbourhood,
      'street': entity.street,
      'location': {
        'type': 'Point',
        'coordinates': CoordinatesAdapter.toJson(entity.coordinates),
      },
    };
  }
}
