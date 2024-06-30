import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/ui/screen/todo_add/todo_add_screen.dart';
import 'package:todo_app/ui/screen/todo_detail/todo_detail_screen.dart';
import 'package:todo_app/ui/screen/todo_edit/todo_edit_screen.dart';
import 'package:todo_app/ui/screen/todo_list/todo_list_screen.dart';
import 'package:todo_app/ui/theme/theme.dart';

import 'domain/domain_layer.dart';

void main() {
  runApp(const ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      routerConfig: _goRouter,
      theme: theme.light(),
      darkTheme: theme.dark(),
    );
  }
}

final _goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TodoListScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return TodoDetailScreen(todoId);
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const TodoAddScreen(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) {
        final todo = state.extra! as Todo;
        return TodoEditScreen(todo);
      },
    )
  ],
);
