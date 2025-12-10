import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/core/constants/database_constants.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._();

  AppDatabase._();

  factory AppDatabase() {
    return _instance;
  }

  Database? _database;

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE ${DatabaseConstants.favoritesTableName} (
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            image TEXT,
            description TEXT,
            stock INTEGER,
            category TEXT,
            rating REAL,
          )
        ''');
      },
    );
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database as Database;
  }
}
