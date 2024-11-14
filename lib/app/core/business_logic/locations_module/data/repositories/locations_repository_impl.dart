import 'package:desafio_konsi/app/core/business_logic/locations_module/data/adapters/list_locations_adapter.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/repositories/i_locations_repository.dart';
import 'package:desafio_konsi/app/core/client/i_rest_client.dart';
import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:result_dart/result_dart.dart';

class LocationsRepositoryImpl implements ILocationsRepository {
  LocationsRepositoryImpl({
    required this.client,
  });

  final IRestClient client;

  @override
  Future<Output<LocationEntity>> addLocation() {
    // TODO: implement addLocation
    throw UnimplementedError();
  }

  @override
  Future<Output<ListLocationsEntity>> getLocations() async {
    try {
      final response = await Future.value(_apiLocationData());

      return Success(ListLocationsAdapter.fromJson(response));
    } on BaseException catch (error) {
      return Failure(DefaultException(message: error.message));
    } catch (_) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }
}

Map<String, dynamic> _apiLocationData() {
  return {};
}
