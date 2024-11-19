import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';

class CoordinatesAdapter {
  static CoordinatesEntity fromJson(Map<String, dynamic> data) {
    try {
      // Conversão segura para longitude
      double longitude = data['longitude'] is String
          ? double.tryParse(data['longitude']) ?? 0.0
          : data['longitude']?.toDouble() ?? 0.0;

      // Conversão segura para latitude
      double latitude = data['latitude'] is String
          ? double.tryParse(data['latitude']) ?? 0.0
          : data['latitude']?.toDouble() ?? 0.0;

      return CoordinatesEntity(
        data['id'] ?? -1,
        longitude: longitude,
        latitude: latitude,
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }

  static Map<String, dynamic> toJson(CoordinatesEntity entity) {
    return {
      'id': entity.id,
      'longitude': entity.longitude,
      'latitude': entity.latitude,
    };
  }
}
