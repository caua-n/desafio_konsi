import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/location_adapter.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
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
  Future<Output<List<LocationEntity>>> getLocations() async {
    try {
      // Busca localizações do datasource
      final data = await datasource.fetchLocations();

      // Converte os dados recebidos em uma lista de LocationEntity
      final listLocationsEntity =
          data.map((location) => LocationAdapter.fromMap(location)).toList();

      // Retorna sucesso com a lista de entidades (mesmo que esteja vazia)
      return Success(listLocationsEntity);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }
}
