part of '../../ui_layer.dart';

@riverpod
class TodoAddController extends _$TodoAddController {
  @override
  Todo build() {
    return Todo(
      id: const UuidV4().generate(),
      title: '',
    );
  }

  set title(String title) => state = state.copyWith(title: title);
  set note(String? note) => state = state.copyWith(note: note);
  set dateTime(DateTime? dateTime) => state = state.copyWith(dateTime: dateTime);

  Future<void> addTodo() async {
    final repository = await ref.read(todoRepositoryProvider.future);
    await repository.addTodo(state);
    ref.invalidate(todoListControllerProvider);
  }
}
