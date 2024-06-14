import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/database/database_helper.dart';
import 'package:todo_app/data/datasource/todo_datasource.dart';
import 'package:todo_app/domain/model/todo.dart';

import '../database/todo_table_info.dart';

part 'database_todo_datasource.g.dart';

class DatabaseTodoDatasource implements TodoDatasource {
  final Database database;

  const DatabaseTodoDatasource({required this.database});

  @override
  Future<void> addTodo(Todo todo) async {
    final todoInMap = todo.toJson();
    await database.insert(todoTable, todoInMap);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todosInMap = await database.query(todoTable);
    final todos = todosInMap.map(Todo.fromJson).toList();
    return todos;
  }

  @override
  Future<bool> editTodo(Todo todo) async {
    return await database.update(
      todoTable,
      todo.toJson(),
      where: '${Columns.id} = ?',
      whereArgs: [todo.id],
    ) > 0;
  }
}

@riverpod
Future<DatabaseTodoDatasource> todoDatasource(TodoDatasourceRef ref) async {
  final database = await ref.watch(databaseProvider.future);
  return DatabaseTodoDatasource(database: database);
}
