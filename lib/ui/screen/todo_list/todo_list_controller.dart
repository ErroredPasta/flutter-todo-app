import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';
import 'package:todo_app/domain/model/todo.dart';

part 'todo_list_controller.g.dart';

@riverpod
class TodoListController extends _$TodoListController {
  @override
  Future<List<Todo>> build() {
    final todos = ref.watch(todoRepositoryProvider).getTodos();
    return todos;
  }
}
