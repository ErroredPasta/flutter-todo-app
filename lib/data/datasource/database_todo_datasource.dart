part of '../data_layer.dart';

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
        ) >
        0;
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    await database.delete(
      todoTable,
      where: '${Columns.id} = ?',
      whereArgs: [todoId],
    );
  }
}

@riverpod
Future<DatabaseTodoDatasource> todoDatasource(TodoDatasourceRef ref) async {
  final database = await ref.watch(databaseProvider.future);
  return DatabaseTodoDatasource(database: database);
}
