import 'package:desafio_konsi/app/core/services/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';

class LocalLocationsDatasource implements LocationsDatasource {
  final Future<Database> database;

  LocalLocationsDatasource(this.database);

  @override
  Future<List<Map<String, dynamic>>> fetchSavedLocations() async {
    final db = await database;

    final List<Map<String, dynamic>> result =
        await db.query(DatabaseHelper.tableLocations);

    return result;
  }

  @override
  Future<void> saveLocations(List<Map<String, dynamic>> locations) async {
    final db = await database;

    await db.delete(DatabaseHelper.tableLocations);

    for (final location in locations) {
      await db.insert(
        DatabaseHelper.tableLocations,
        location,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> searchCEP(String cep) {
    // TODO: implement searchCEP
    throw UnimplementedError();
  }
}
