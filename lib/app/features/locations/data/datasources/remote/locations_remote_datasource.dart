import 'package:dio/dio.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';

const _apiUrl = 'https://example.com/api/locations';

class RemoteLocationsDatasource implements LocationsDatasource {
  final Dio dio;

  RemoteLocationsDatasource(this.dio);

  @override
  Future<Map<String, dynamic>> fetchLocations() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(_apiUrl);

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar localizações remotas: $e');
    }
  }
}
