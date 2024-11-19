import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';

class FallbackLocationsDatasource implements LocationsDatasource {
  final LocationsDatasource remoteDatasource;
  final LocationsDatasource localDatasource;

  FallbackLocationsDatasource({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<void> addLocation(Map<String, dynamic> location) async {
    try {
      // Tenta salvar na fonte remota
      await remoteDatasource.addLocation(location);
    } catch (e) {
      // Em caso de falha, salva localmente
      print('Falha no salvamento remoto, salvando localmente: $e');
      await localDatasource.addLocation(location);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSavedLocations() async {
    try {
      final remoteData = await remoteDatasource.fetchSavedLocations();

      if (remoteData.isNotEmpty) {
        for (final location in remoteData) {
          await localDatasource.addLocation(location);
        }
        return remoteData;
      }

      return await localDatasource.fetchSavedLocations();
    } catch (e) {
      print('Erro ao buscar localizações remotas, usando local: $e');
      return await localDatasource.fetchSavedLocations();
    }
  }

  @override
  Future<Map<String, dynamic>> searchCEP(String cep) async {
    try {
      // Sempre usa a fonte remota para buscar CEP
      return await remoteDatasource.searchCEP(cep);
    } catch (e) {
      // Em caso de erro, lança uma exceção
      print('Erro ao buscar CEP remotamente: $e');
      throw Exception('Erro ao buscar CEP.');
    }
  }
}
