part of '../data_layer.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDatasource datasource;

  TodoRepositoryImpl({required this.datasource});

  @override
  Future<List<Todo>> getTodos() {
    return datasource.getTodos();
  }

  @override
  Future<void> addTodo(Todo todo) {
    return datasource.addTodo(todo);
  }

  @override
  Future<bool> editTodo(Todo todo) {
    return datasource.editTodo(todo);
  }

  @override
  Future<void> deleteTodo(String todoId) {
    return datasource.deleteTodo(todoId);
  }
}

@riverpod
Future<TodoRepository> todoRepository(TodoRepositoryRef ref) async {
  final datasource = await ref.watch(todoDatasourceProvider.future);
  return TodoRepositoryImpl(datasource: datasource);
}
