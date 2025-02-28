
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  Future<Database> openDatabase1() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'employee_info.db';
    String fullPath = join(dbPath, dbName);
    Database database = await openDatabase(
      fullPath,
      onCreate: (db, version) async {
        await db.execute('''
         CREATE TABLE employees (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            profile_image TEXT,
            name TEXT,
            email TEXT,
            address TEXT,
            phone TEXT,
            website TEXT,
            company_name TEXT,
            company_details TEXT
          )
        ''');
      },
      version: 1,
    );
    return database;
  }

  Future<void> deleteDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'employee_info.db';
    String fullPath = join(dbPath, dbName);
    await deleteDatabase(fullPath);
  }

}
