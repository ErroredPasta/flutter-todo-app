import 'package:todo_app/domain/model/todo.dart';

abstract class TodoDatasource {
  Future<List<Todo>> getTodos();
}
