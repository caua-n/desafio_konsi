import 'package:desafio_konsi/app/modules/locations_module/data/adapters/list_locations_adapter.dart';
import 'package:desafio_konsi/app/modules/locations_module/data/adapters/location_adapter.dart';
import 'package:desafio_konsi/app/modules/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/modules/locations_module/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/modules/locations_module/domain/repositories/i_locations_repository.dart';
import 'package:desafio_konsi/app/core/client/i_rest_client.dart';
import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:result_dart/result_dart.dart';

class LocationsRepositoryImpl implements ILocationsRepository {
  LocationsRepositoryImpl({required this.client, required this.hiveBox});

  final IRestClient client;
  final Box hiveBox;

  @override
  Future<Output<LocationEntity>> addLocation() {
    throw UnimplementedError();
  }

  @override
  Future<Output<ListLocationsEntity>> getLocations() async {
    try {
      if (hiveBox.isNotEmpty) {
        final localData = hiveBox.values
            .map((locationData) => LocationAdapter.fromHive(locationData))
            .toList();
        return Success(ListLocationsEntity(1, locations: localData));
      }

      final apiLocations =
          ListLocationsAdapter.fromJson(_responseGetLocations());

      for (var location in apiLocations.locations) {
        hiveBox.put(location.id, LocationAdapter.toHive(location));
      }

      return Success(apiLocations);
    } on BaseException catch (error) {
      return Failure(DefaultException(message: error.message));
    } catch (_) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }
}

Map<String, dynamic> _responseGetLocations() {
  return {
    "id": "1",
    "locations": [
      {
        "id": 0,
        "cep": 85851030,
        "address": "Rua Marechal Deodoro da Fonseca",
        "addressNumber": 1606,
        "complement": "Apto 26"
      },
      {
        "id": 1,
        "cep": 85851020,
        "address": "Rua Marechal Floriano Peixoto",
        "addressNumber": 960,
        "complement": "Apto 27"
      },
      {
        "id": 2,
        "cep": 85851040,
        "address": "Rua Santos Dumont",
        "addressNumber": 728,
        "complement": "Casa"
      }
    ]
  };
}
