import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';

class FallbackLocationsDatasource implements LocationsDatasource {
  final LocationsDatasource remoteDatasource;
  final LocationsDatasource localDatasource;

  FallbackLocationsDatasource({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<Map<String, dynamic>>> fetchSavedLocations() async {
    final remoteData = await remoteDatasource.fetchSavedLocations();

    if (remoteData.isNotEmpty) {
      await localDatasource.saveLocations(remoteData);
      return remoteData;
    }

    return await localDatasource.fetchSavedLocations();
  }

  @override
  Future<void> saveLocations(List<Map<String, dynamic>> locations) async {
    await localDatasource.saveLocations(locations);
  }

  @override
  Future<Map<String, dynamic>> searchCEP(String cep) async {
    return await remoteDatasource.searchCEP(cep);
  }
}
