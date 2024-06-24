part of '../../ui_layer.dart';

@riverpod
class TodoListController extends _$TodoListController {
  @override
  Future<List<Todo>> build() async {
    final repository = await ref.watch(todoRepositoryProvider.future);
    return repository.getTodos();
  }
}
