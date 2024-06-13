import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/database/todo_table_info.dart';

final Map<int, Future<void> Function(Database)> databaseMigrations = {
  2: migrateFromV1ToV2
};

Future<void> migrateFromV1ToV2(Database database) async {
  final batch = database.batch();
  const newTodoTableName = 'new_todos';

  batch.execute('''
    CREATE TABLE $newTodoTableName (
      ${Columns.id} TEXT NOT NULL UNIQUE,
      ${Columns.title} TEXT NOT NULL,
      ${Columns.done} INTEGER NOT NULL,
      ${Columns.dateTime} TEXT,
      ${Columns.note} TEXT,
      PRIMARY KEY(${Columns.id})
    )
  ''');

  final List<Map<String, dynamic>> oldData = await database.query(todoTable);

  for (final data in oldData) {
    batch.insert(newTodoTableName, {
      Columns.id: data[Columns.id],
      Columns.title: data['todo'],
      Columns.done: data[Columns.done],
      Columns.dateTime: data[Columns.dateTime],
      Columns.note: null,
    });
  }

  batch.execute('DROP TABLE $todoTable');
  batch.execute('ALTER TABLE $newTodoTableName RENAME TO $todoTable');

  await batch.commit();
}
