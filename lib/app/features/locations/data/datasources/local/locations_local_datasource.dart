import 'package:desafio_konsi/app/core/services/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/i_locations_datasource.dart';

class LocalLocationsDatasource implements ILocationsDatasource {
  final Future<Database> database;

  LocalLocationsDatasource(this.database);

  @override
  Future<List<Map<String, dynamic>>> getLocations() async {
    final db = await database;

    final List<Map<String, dynamic>> result =
        await db.query(DatabaseHelper.tableLocations);

    return result.map((location) {
      final mutableLocation = Map<String, dynamic>.from(location);
      mutableLocation['coordinates'] = {
        'latitude': location[DatabaseHelper.columnLatitude],
        'longitude': location[DatabaseHelper.columnLongitude],
      };
      return mutableLocation;
    }).toList();
  }

  @override
  Future<void> addLocation(Map<String, dynamic> location) async {
    final db = await database;

    if (location['location'] == null ||
        location['location']['coordinates'] == null ||
        location['location']['coordinates']['latitude'] == null ||
        location['location']['coordinates']['longitude'] == null) {
      throw Exception('Coordenadas inválidas ou ausentes no objeto location.');
    }

    final latitude = location['location']['coordinates']['latitude'];
    final longitude = location['location']['coordinates']['longitude'];

    await db.insert(
      DatabaseHelper.tableLocations,
      {
        DatabaseHelper.columnId: null,
        DatabaseHelper.columnCep: location['cep'],
        DatabaseHelper.columnState: location['state'],
        DatabaseHelper.columnCity: location['city'],
        DatabaseHelper.columnNeighbourhood: location['neighbourhood'],
        DatabaseHelper.columnStreet: location['street'],
        DatabaseHelper.columnLatitude: latitude,
        DatabaseHelper.columnLongitude: longitude,
        DatabaseHelper.columnAddressNumber: location['number'],
        DatabaseHelper.columnComplement: location['complement'],
      },
    );
  }

  @override
  Future<void> deleteLocation(int locationId) async {
    final db = await database;

    final result = await db.delete(
      DatabaseHelper.tableLocations,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [locationId],
    );

    if (result == 0) {
      throw Exception('Falha ao deletar a localização com ID $locationId.');
    }
  }

  @override
  Future<void> updateLocation(Map<String, dynamic> location) async {
    final db = await database;

    if (!location.containsKey('id') || location['id'] == null) {
      throw Exception('ID da localização é obrigatório para a atualização.');
    }

    final int locationId = location['id'];
    final latitude = location['location']['coordinates']['latitude'];
    final longitude = location['location']['coordinates']['longitude'];

    final updatedData = {
      'cep': location['cep'],
      'state': location['state'],
      'city': location['city'],
      'neighbourhood': location['neighbourhood'],
      'street': location['street'],
      'latitude': latitude,
      'longitude': longitude,
    };

    await db.update(
      DatabaseHelper.tableLocations,
      updatedData,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [locationId],
    );
  }

  @override
  Future<Map<String, dynamic>> searchCEP(String cep) {
    throw UnimplementedError();
  }
}
