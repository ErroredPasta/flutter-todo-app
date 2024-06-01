import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/data/datasource/in_memory_todo_datasource.dart';
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
}

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) {
  final datasource = ref.watch(todoDatasourceProvider);
  return TodoRepositoryImpl(datasource: datasource);
}
