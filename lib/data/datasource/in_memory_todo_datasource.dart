// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/data/datasource/todo_datasource.dart';
import 'package:todo_app/domain/model/todo.dart';

// part 'in_memory_todo_datasource.g.dart';

class InMemoryTodoDatasource implements TodoDatasource {
  final List<Todo> _todo = [
    const Todo(id: 'id1', todo: 'todo1'),
    Todo(id: 'id2', todo: 'todo2', done: true, dateTime: DateTime.now())
  ];

  @override
  Future<List<Todo>> getTodos() async {
    return _todo;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _todo.add(todo);
  }
}

// @riverpod
// TodoDatasource todoDatasource(TodoDatasourceRef ref) {
//   return InMemoryTodoDatasource();
// }
