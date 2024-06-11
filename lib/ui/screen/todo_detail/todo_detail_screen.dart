import 'package:flutter/material.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/ui/screen/todo_edit/todo_edit_screen.dart';
import 'package:todo_app/ui/util/date_time_formatter.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailScreen(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.todo,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 32),
          if (todo.dateTime != null)
            Text('needs to be done until ${formatDateTime(todo.dateTime!)}'),
          if (todo.dateTime != null) const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => _showEditScreen(context, todo),
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditScreen(BuildContext context, Todo todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => TodoEditScreen(todo),
    ));
  }
}
