import 'package:todo_app/domain/model/todo.dart';

abstract class TodoDatasource {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> editTodo(Todo todo);
}
