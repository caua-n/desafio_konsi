import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const tableLocations = 'locations';
  static const columnId = 'id';
  static const columnCep = 'cep';
  static const columnState = 'state';
  static const columnCity = 'city';
  static const columnNeighbourhood = 'neighbourhood';
  static const columnStreet = 'street';
  static const columnLatitude = 'latitude';
  static const columnLongitude = 'longitude';
  static const columnAddressNumber = 'address_number';
  static const columnComplement = 'complement';

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'locations.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableLocations (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCep TEXT NOT NULL,
            $columnState TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnNeighbourhood TEXT NOT NULL,
            $columnStreet TEXT NOT NULL,
            $columnLatitude REAL NOT NULL,
            $columnLongitude REAL NOT NULL,
            $columnAddressNumber TEXT NOT NULL,
            $columnComplement TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
              'ALTER TABLE $tableLocations ADD COLUMN $columnLatitude REAL;');
          await db.execute(
              'ALTER TABLE $tableLocations ADD COLUMN $columnLongitude REAL;');
        }
      },
    );
  }
}
