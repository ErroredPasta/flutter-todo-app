import 'package:todo_app/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
}
