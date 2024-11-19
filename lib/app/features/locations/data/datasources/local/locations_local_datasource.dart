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
  Future<Map<String, dynamic>> searchCEP(String cep) {
    // TODO: implement searchCEP
    throw UnimplementedError();
  }
}
