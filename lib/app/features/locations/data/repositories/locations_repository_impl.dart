import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/list_locations_adapter.dart';

import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';
import 'package:result_dart/result_dart.dart';

class LocationsRepositoryImpl implements ILocationsRepository {
  final LocationsDatasource datasource;

  LocationsRepositoryImpl(this.datasource);

  @override
  Future<Output<LocationEntity>> addLocation() {
    throw UnimplementedError();
  }

  @override
  Future<Output<ListLocationsEntity>> getLocations() async {
    try {
      final data = await datasource.fetchLocations();

      final listLocationsEntity = ListLocationsAdapter.fromJson(data);

      return Success(listLocationsEntity);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }
}
