import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';

class FallbackLocationsDatasource implements LocationsDatasource {
  final LocationsDatasource remoteDatasource;
  final LocationsDatasource localDatasource;

  FallbackLocationsDatasource({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<Map<String, dynamic>>> fetchLocations() async {
    final remoteData = await remoteDatasource.fetchLocations();

    if (remoteData.isNotEmpty) {
      // Salva os dados remotos no banco local
      await localDatasource.saveLocations(remoteData);
      return remoteData;
    }

    // Caso remoto falhe, retorna os dados locais
    return await localDatasource.fetchLocations();
  }

  @override
  Future<void> saveLocations(List<Map<String, dynamic>> locations) async {
    // Apenas delega para o localDatasource
    await localDatasource.saveLocations(locations);
  }
}
