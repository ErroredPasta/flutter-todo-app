part of '../ui_layer.dart';

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

  Future<bool> editTodo(Todo todo) async {
    final repository = await ref.watch(todoRepositoryProvider.future);
    final isChanged = await repository.editTodo(todo);
    ref.invalidateSelf();

    return isChanged;
  }

  Future<void> deleteTodo(String todoId) async {
    final repository = await ref.watch(todoRepositoryProvider.future);
    repository.deleteTodo(todoId);
    ref.invalidateSelf();
  }

  Future<bool> toggleDone(Todo todo) {
    return editTodo(todo.copyWith(done: !todo.done));
  }
}
