part of '../../ui_layer.dart';

@riverpod
class TodoEditController extends _$TodoEditController {
  @override
  Todo build(Todo todo) {
    return todo;
  }

  set title(String title) => state = state.copyWith(title: title);
  set note(String? note) => state = state.copyWith(note: note);
  set dateTime(DateTime? dateTime) => state = state.copyWith(dateTime: dateTime);

  Future<void> editTodo() async {
    final repository = await ref.read(todoRepositoryProvider.future);
    await repository.editTodo(state);
    ref.invalidate(todoListControllerProvider);
  }
}
