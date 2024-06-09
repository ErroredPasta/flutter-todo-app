import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'todo_table_info.dart';

part 'database_helper.g.dart';

class DatabaseHelper {
  static const _databaseName = "todoDatabase.db";
  static const _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $table (
            ${Columns.id}	TEXT NOT NULL UNIQUE,
            ${Columns.todo}	TEXT NOT NULL,
            ${Columns.done}	INTEGER NOT NULL,
            ${Columns.dateTime}	TEXT,
            PRIMARY KEY(${Columns.id})
          )
          ''');
      },
    );
  }
}

@riverpod
Future<Database> database(DatabaseRef ref) async {
  return await DatabaseHelper.instance.database;
}
