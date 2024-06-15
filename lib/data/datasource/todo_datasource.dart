import '../../domain/domain_layer.dart';

abstract class TodoDatasource {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<bool> editTodo(Todo todo);
  Future<void> deleteTodo(String todoId);
}
