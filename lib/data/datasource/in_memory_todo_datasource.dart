// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/data/datasource/todo_datasource.dart';
import 'package:todo_app/domain/model/todo.dart';

// part 'in_memory_todo_datasource.g.dart';

class InMemoryTodoDatasource implements TodoDatasource {
  final List<Todo> _todo = [
    const Todo(id: 'id1', title: 'todo1'),
    Todo(id: 'id2', title: 'todo2', done: true, dateTime: DateTime.now())
  ];

  @override
  Future<List<Todo>> getTodos() async {
    return _todo;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _todo.add(todo);
  }

  @override
  Future<void> editTodo(Todo todo) async {
    final index = _todo.indexWhere(
      (t) => t.id == todo.id,
    );

    if (index == -1) throw Exception('Todo with id ${todo.id} not found');

    _todo[index] = todo;
  }
}

// @riverpod
// TodoDatasource todoDatasource(TodoDatasourceRef ref) {
//   return InMemoryTodoDatasource();
// }
