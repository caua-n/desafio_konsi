import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/location_adapter.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/i_locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:result_dart/result_dart.dart';

class LocationsRepositoryImpl implements ILocationsRepository {
  final ILocationsDatasource datasource;

  LocationsRepositoryImpl(this.datasource);

  @override
  Future<Output<LocationEntity>> addLocation(
      LocationEntity selectedLocation, String number, String complement) async {
    try {
      final locationJson = LocationAdapter.toJson(selectedLocation);
      locationJson.addAll({
        'number': number,
        'complement': complement,
      });

      await datasource.addLocation(locationJson);

      return Success(selectedLocation);
    } catch (e) {
      print('Erro no repositório: $e');
      return const Failure(
          DefaultException(message: 'Erro ao salvar localização.'));
    }
  }

  @override
  Future<Output<List<LocationEntity>>> getLocations() async {
    try {
      final data = await datasource.getLocations();

      final listLocationsEntity =
          data.map((location) => LocationAdapter.fromJson(location)).toList();

      return Success(listLocationsEntity);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }

  @override
  Future<Output<bool>> deleteLocation(int locationId) async {
    try {
      await datasource.deleteLocation(locationId);

      return const Success(true);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(
          message: 'Erro desconhecido ao deletar localização.'));
    }
  }

  @override
  Future<Output<bool>> updateLocation(
      LocationEntity selectedLocation, String number, String complement) async {
    try {
      final locationJson = LocationAdapter.toJson(selectedLocation);
      locationJson.addAll({
        'number': number,
        'complement': complement,
      });

      await datasource.updateLocation(locationJson);

      return const Success(true);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(
          message: 'Erro desconhecido ao atualizar localização.'));
    }
  }

  @override
  Future<Output<List<LocationEntity>>> searchPostalCode(String cep) async {
    try {
      final remoteData = await datasource.searchCEP(cep);

      if (remoteData.isEmpty) {
        return const Failure(DefaultException(message: 'CEP não encontrado.'));
      }

      final locationEntity = LocationAdapter.fromJson(remoteData);

      return Success([locationEntity]);
    } on BaseException catch (e) {
      return Failure(DefaultException(message: e.message));
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }

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
        'neighborhood': place.subLocality,
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
