import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/location_adapter.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:result_dart/result_dart.dart';

class LocationsRepositoryImpl implements ILocationsRepository {
  final LocationsDatasource datasource;

  LocationsRepositoryImpl(this.datasource);

  @override
  Future<Output<LocationEntity>> addLocation(
      LocationEntity location, String number, String complement) async {
    try {
      final locationJson = LocationAdapter.toJson(location);
//vai ficar assim com o addAll
//       {
//   "id": ,
//   "cep": "",
//   "state": "",
//   "city": "",
//   "neighborhood": "",
//   "street": "",
//   "location": {
//     "type": "",
//     "coordinates": {
//       "latitude": ,
//       "longitude":
//     }
//   },
//   "number": "",
//   "complement": ""
// }
      locationJson.addAll({
        'number': number,
        'complement': complement,
      });

      await datasource.addLocation(locationJson);

      return Success(location);
    } catch (e) {
      print('Erro no repositório: $e');
      return const Failure(
          DefaultException(message: 'Erro ao salvar localização.'));
    }
  }

  @override
  Future<Output<List<LocationEntity>>> getLocations() async {
    try {
      final data = await datasource.fetchSavedLocations();

      final listLocationsEntity =
          data.map((location) => LocationAdapter.fromSql(location)).toList();

      return Success(listLocationsEntity);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }

  @override
  Future<Output<List<LocationEntity>>> searchPostalCode(String cep) async {
    try {
      final remoteData = await datasource.searchCEP(cep);

      if (remoteData.isEmpty) {
        return const Failure(DefaultException(
            message:
                'CEP não encontrado.')); //TODO: TRATAR MELHOR SE CEP N FOR ENCONTRADO
      }

      final locationEntity = LocationAdapter.fromJson(remoteData);

      return Success([locationEntity]);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }

  //TODO: estudar se essa função precisa de um repository pra isso, ja que é de outra api
  @override
  Future<Output<LocationEntity>> searchCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      final Placemark place = placemarks.first;

      final data = {
        'cep': place.postalCode,
        'state': place.administrativeArea,
        'city': place.subAdministrativeArea,
        'neighborhood': place
            .subLocality, //ALTERADO POR CONTA DO BRASILAPI, ESCREVERAM ERRADO!
        'street': place.street,
        'location': {
          'coordinates': {
            'latitude': latitude,
            'longitude': longitude,
          }
        },
      };
      final locationEntity = LocationAdapter.fromJson(data);

      return Success(locationEntity);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }
}
