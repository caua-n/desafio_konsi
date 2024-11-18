import 'package:dio/dio.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';

const _apiUrl = 'https://konsi.com/api/locations'; //falhara propositalmente

class RemoteLocationsDatasource implements LocationsDatasource {
  final Dio dio;

  RemoteLocationsDatasource(this.dio);

  @override
  Future<Map<String, dynamic>> searchCEP(String cep) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'https://brasilapi.com.br/api/cep/v2/$cep',
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        return {};
      }
    } catch (e) {
      print('Erro ao buscar localização remota: $e');
      return {};
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSavedLocations() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(_apiUrl);

      if (response.statusCode == 200 && response.data != null) {
        return (response.data!['locations'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao buscar localizações remotas: $e');
      return [];
    }
  }

  @override
  Future<void> saveLocations(List<Map<String, dynamic>> locations) async {
    throw UnsupportedError(
        'Remote datasource não suporta salvar localizações.');
  }
}
