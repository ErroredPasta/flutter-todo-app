import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';
import 'package:todo_app/domain/model/todo.dart';

part 'todo_list_controller.g.dart';

@riverpod
class TodoListController extends _$TodoListController {
  @override
  Future<List<Todo>> build() async {
    final repository = await ref.watch(todoRepositoryProvider.future);
    return repository.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    final repository = await ref.watch(todoRepositoryProvider.future);
    await repository.addTodo(todo);
    ref.invalidateSelf();
  }
}
