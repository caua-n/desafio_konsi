import 'package:desafio_konsi/app/core/business_logic/locations_module/data/adapters/location_adapter.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/core/errors/adapter_exception.dart';

class ListLocationsAdapter {
  static ListLocationsEntity fromJson(Map<String, dynamic> data) {
    try {
      return ListLocationsEntity(
        data['id'] ?? '',
        locations: (data['locations'] as List)
            .map((locations) => LocationAdapter.fromJson(locations))
            .toList(),
      );
    } catch (e) {
      throw AdapterException(message: e.toString());
    }
  }
}
