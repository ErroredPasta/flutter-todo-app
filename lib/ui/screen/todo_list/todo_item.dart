import 'package:flutter/material.dart';
import 'package:todo_app/ui/screen/todo_detail/todo_detail_screen.dart';

import '../../../domain/domain_layer.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: InkWell(
        onTap: () => _onTodoItemTap(context, todo),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    todo.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          decoration:
                              todo.done ? TextDecoration.lineThrough : null,
                          color: todo.done ? Colors.grey : null,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (todo.dateTime != null)
                    Text(
                      _formatDateTime(todo.dateTime!),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diffInDays = dateTime.difference(now).inDays;
    final time = '${dateTime.hour}:${dateTime.minute}';

    return '${switch (diffInDays) {
      0 => 'Today',
      1 => 'Tomorrow',
      _ => '${dateTime.year}.${dateTime.month}.${dateTime.day}'
    }} $time';
  }

  void _onTodoItemTap(BuildContext context, Todo todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => TodoDetailScreen(todo),
    ));
  }
}
