import 'package:desafio_konsi/app/features/locations/data/datasources/i_locations_datasource.dart';

class LocationsDatasourceImpl implements ILocationsDatasource {
  final ILocationsDatasource remoteDatasource;
  final ILocationsDatasource localDatasource;

  LocationsDatasourceImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<void> addLocation(Map<String, dynamic> location) async {
    try {
      await remoteDatasource.addLocation(location);
    } catch (e) {
      print('Falha no salvamento remoto, salvando localmente: $e');
      try {
        await localDatasource.addLocation(location);
      } catch (localError) {
        print('Erro ao salvar localmente após falha remota: $localError');
        throw Exception(
            'Falha ao salvar localização remotamente e localmente.');
      }
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLocations() async {
    try {
      final remoteData = await remoteDatasource.getLocations();

      if (remoteData.isNotEmpty) {
        for (final location in remoteData) {
          await localDatasource.addLocation(location);
        }
        return remoteData;
      }
      return await localDatasource.getLocations();
    } catch (e) {
      print('Erro ao buscar localizações remotas, usando local: $e');
      return await localDatasource.getLocations();
    }
  }

  @override
  Future<void> deleteLocation(int locationId) async {
    try {
      await remoteDatasource.deleteLocation(locationId);
    } catch (e) {
      print('Falha ao deletar remotamente, tentando localmente: $e');
      try {
        await localDatasource.deleteLocation(locationId);
      } catch (localError) {
        print('Erro ao deletar localmente após falha remota: $localError');
        throw Exception(
            'Falha ao deletar localização remotamente e localmente.');
      }
    }
  }

  @override
  Future<void> updateLocation(Map<String, dynamic> location) async {
    try {
      await remoteDatasource.updateLocation(location);
    } catch (e) {
      print('Falha na atualização remota, tentando localmente: $e');
      try {
        await localDatasource.updateLocation(location);
      } catch (localError) {
        print('Erro ao atualizar localmente após falha remota: $localError');
        throw Exception(
            'Falha ao atualizar localização remotamente e localmente.');
      }
    }
  }

  @override
  Future<Map<String, dynamic>> searchCEP(String cep) async {
    try {
      return await remoteDatasource.searchCEP(cep);
    } catch (e) {
      print('Erro ao buscar CEP remotamente: $e');
      throw Exception('Erro ao buscar CEP.');
    }
  }
}
