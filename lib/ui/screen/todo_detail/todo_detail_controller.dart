part of '../../ui_layer.dart';

@riverpod
class TodoDetailController extends _$TodoDetailController {
  @override
  Future<Todo> build(String todoId) async {
    final todos = await ref.watch(todoListControllerProvider.future);
    return todos.firstWhere(
      (todo) => todo.id == todoId,
    );
  }

  Future<void> deleteTodo() async {
    final repository = await ref.watch(todoRepositoryProvider.future);
    await repository.deleteTodo(todoId);
    ref.invalidate(todoListControllerProvider);
  }

  Future<void> toggleDone() async {
    final todo = state.requireValue;
    final repository = await ref.watch(todoRepositoryProvider.future);

    await repository.editTodo(todo.copyWith(done: !todo.done));
    ref.invalidate(todoListControllerProvider);
  }
}
