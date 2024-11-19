import 'package:dio/dio.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/i_locations_datasource.dart';

const _apiUrl = 'https://konsi.com/api/locations'; // URL base da API

class RemoteLocationsDatasource implements ILocationsDatasource {
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
  Future<void> addLocation(Map<String, dynamic> location) async {
    try {
      await dio.post<Map<String, dynamic>>(
        '$_apiUrl/add',
        data: location,
      );
    } catch (e) {
      print('Erro ao salvar localização remota: $e');
      throw Exception('Erro ao adicionar localização remotamente.');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLocations() async {
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
  Future<void> deleteLocation(int locationId) async {
    try {
      final response = await dio.delete<Map<String, dynamic>>(
        '$_apiUrl/$locationId',
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao deletar localização com ID: $locationId.');
      }
    } catch (e) {
      print('Erro ao deletar localização remota: $e');
      throw Exception('Erro ao deletar localização remotamente.');
    }
  }

  @override
  Future<void> updateLocation(Map<String, dynamic> location) async {
    if (!location.containsKey('id') || location['id'] == null) {
      throw Exception('ID da localização é obrigatório para a atualização.');
    }

    final int locationId = location['id'];

    try {
      final response = await dio.put<Map<String, dynamic>>(
        '$_apiUrl/$locationId',
        data: location,
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao atualizar localização com ID: $locationId.');
      }
    } catch (e) {
      print('Erro ao atualizar localização remota: $e');
      throw Exception('Erro ao atualizar localização remotamente.');
    }
  }
}
