import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/screen/todo_list/todo_list_screen.dart';
import 'package:todo_app/ui/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = MaterialTheme(textTheme);

    return MaterialApp(
      home: const TodoListScreen(),
      theme: theme.light(),
      darkTheme: theme.dark(),
    );
  }
}

