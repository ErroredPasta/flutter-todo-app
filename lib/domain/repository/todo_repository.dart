import 'package:todo_app/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<bool> editTodo(Todo todo);
  Future<void> deleteTodo(String todoId);
}
