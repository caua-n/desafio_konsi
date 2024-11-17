import 'dart:io';
import 'package:desafio_konsi/app/features/locations/data/datasources/local/locations_local_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/remote/locations_remote_datasource.dart';

class FallbackLocationsDatasource implements LocationsDatasource {
  final LocalLocationsDatasource localDatasource;
  final RemoteLocationsDatasource remoteDatasource;

  FallbackLocationsDatasource({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Map<String, dynamic>> fetchLocations() async {
    try {
      // Tenta buscar do remoto se houver conexão
      if (await _hasInternetConnection()) {
        return await remoteDatasource.fetchLocations();
      }
    } catch (e) {
      print('Erro ao buscar do remoto: $e');
    }

    // Caso falhe, busca do local
    return await localDatasource.fetchLocations();
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
