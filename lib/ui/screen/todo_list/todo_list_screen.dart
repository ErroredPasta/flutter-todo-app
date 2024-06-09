import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/ui/screen/todo_add/todo_add_screen.dart';
import 'package:todo_app/ui/screen/todo_list/todo_item.dart';
import 'package:todo_app/ui/screen/todo_list_controller.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListControllerProvider);

    return Scaffold(
      body: todos.when(
        data: _onSuccess,
        error: _onError,
        loading: _onLoading,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _onSuccess(List<Todo> todos) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: todos
              .map(
                (todo) => TodoItem(todo),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return Text(error.toString());
  }

  Widget _onLoading() {
    return const CircularProgressIndicator();
  }

  void _showAddScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const TodoAddScreen(),
      ),
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
