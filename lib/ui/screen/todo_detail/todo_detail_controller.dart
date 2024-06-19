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
}
