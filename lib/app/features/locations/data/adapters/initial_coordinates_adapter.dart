import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/initial_coordinates_entity.dart';

class InitialCoordinatesAdapter {
  static InitialCoordinatesEntity fromJson(Map<String, dynamic> data) {
    try {
      return InitialCoordinatesEntity(
        data['id'] ?? -1,
        longitude: data['longitude'] ?? 0.0,
        latitude: data['latitude'] ?? 0.0,
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static Map<String, dynamic> toJson(InitialCoordinatesEntity entity) {
    return {
      'longitude': entity.longitude,
      'latitude': entity.latitude,
    };
  }
}
