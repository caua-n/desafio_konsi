import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/repositories/i_locations_repository.dart';
import 'package:desafio_konsi/app/core/client/i_rest_client.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:result_dart/result_dart.dart';

class LocationsRepositoryImpl implements ILocationsRepository {
  LocationsRepositoryImpl({
    required this.client,
  });

  final IRestClient client;

  @override
  Future<Output<Unit>> addLocation() {
    // TODO: implement addLocation
    throw UnimplementedError();
  }
}
