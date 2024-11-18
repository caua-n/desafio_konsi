import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';

class CoordinatesAdapter {
  static CoordinatesEntity fromJson(Map<String, dynamic> data) {
    try {
      return CoordinatesEntity(
        data['id'] ?? -1,
        longitude: data['longitude'] ?? '',
        latitude: data['latitude'] ?? '',
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static Map<String, dynamic> toJson(CoordinatesEntity entity) {
    return {
      'longitude': entity.longitude,
      'latitude': entity.latitude,
    };
  }
}
