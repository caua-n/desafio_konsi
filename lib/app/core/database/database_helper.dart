import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'locations.db';
  static const _databaseVersion = 1;

  static const tableLocations = 'locations';
  static const columnId = 'id';
  static const columnCep = 'cep';
  static const columnAddress = 'address';
  static const columnAddressNumber = 'address_number';
  static const columnComplement = 'complement';

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableLocations (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCep TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnAddressNumber TEXT NOT NULL,
            $columnComplement TEXT
          )
        ''');
      },
    );
  }
}
