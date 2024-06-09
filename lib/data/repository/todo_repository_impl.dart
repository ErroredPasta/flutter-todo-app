import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/data/datasource/database_todo_datasource.dart';
import 'package:todo_app/data/datasource/todo_datasource.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

part 'todo_repository_impl.g.dart';

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
}

@riverpod
Future<TodoRepository> todoRepository(TodoRepositoryRef ref) async {
  final datasource = await ref.watch(todoDatasourceProvider.future);
  return TodoRepositoryImpl(datasource: datasource);
}
