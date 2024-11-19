import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/coordinates_adapter.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

class LocationAdapter {
  static LocationEntity fromJson(Map<String, dynamic> data) {
    try {
      return LocationEntity(
        data['id'] ?? -1,
        postalCode: data['cep'] ?? '',
        state: data['state'] ?? '',
        city: data['city'] ?? '',
        neighbourhood: data['neighbourhood'] ?? '',
        street: data['street'] ?? '',
        coordinates:
            data['location'] != null && data['location']['coordinates'] != null
                ? CoordinatesAdapter.fromJson(data['location']['coordinates'])
                : throw const AdapterException(
                    message: 'Campo location ou coordinates está ausente'),
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static LocationEntity fromPlacemark(
      Map<String, dynamic> data, CoordinatesEntity coordinates) {
    return LocationEntity(
      data['id'],
      postalCode: data['postalCode'] ?? '',
      state: data['administrativeArea'] ?? '',
      city: data['locality'] ?? '',
      neighbourhood: data['subLocality'] ?? '',
      street: data['street'] ?? '',
      coordinates: coordinates,
    );
  }

  static Map<String, dynamic> toJson(LocationEntity entity) {
    return {
      'id': entity.id,
      'cep': entity.postalCode,
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
