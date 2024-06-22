part of '../data_layer.dart';

class DatabaseHelper {
  static const _databaseName = "todoDatabase.db";
  static final _databaseVersion = 1 + databaseMigrations.length;

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
      onCreate: (db, version) async {
        db.execute('''
          CREATE TABLE $todoTable (
            ${Columns.id}	TEXT NOT NULL UNIQUE,
            todo TEXT NOT NULL,
            ${Columns.done}	INTEGER NOT NULL,
            ${Columns.dateTime}	TEXT,
            PRIMARY KEY(${Columns.id})
          )
          ''');

        await migrate(db, 1, version);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await migrate(db, oldVersion, newVersion);
      },
    );
  }

  Future<void> migrate(Database db, int from, int to) async {
    for (int v = from + 1; v <= to; ++v) {
      final migrationFunction = databaseMigrations[v]!;
      await migrationFunction(db);
    }
  }
}

@riverpod
Future<Database> database(DatabaseRef ref) async {
  return await DatabaseHelper.instance.database;
}
