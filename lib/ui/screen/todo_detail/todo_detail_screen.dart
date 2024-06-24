import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_detail/widget/delete_dialog.dart';
import 'package:todo_app/ui/screen/todo_detail/widget/detail_screen_date_time_section.dart';
import 'package:todo_app/ui/screen/todo_detail/widget/detail_screen_note_section.dart';
import 'package:todo_app/ui/screen/todo_edit/todo_edit_screen.dart';

import '../../../domain/domain_layer.dart';
import '../../ui_layer.dart';

class TodoDetailScreen extends ConsumerWidget {
  final String todoId;

  const TodoDetailScreen(this.todoId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsync = ref.watch(todoDetailControllerProvider(todoId));
    final controller = ref.watch(todoDetailControllerProvider(todoId).notifier);

    return todoAsync.when(
      data: (todo) => _onSuccess(todo, controller, context),
      error: _onError,
      loading: _onLoading,
    );
  }

  Widget _onSuccess(Todo todo, TodoDetailController controller, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.dateTime != null)
              DetailScreenDateTimeSection(todo.dateTime!),
            if (todo.dateTime != null) const SizedBox(height: 16),
            const SizedBox(height: 16),
            DetailScreenNoteSection(todo.note),
            const SizedBox(height: 16),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: roundedRectangleButtonStyle.copyWith(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primaryContainer,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    onPressed: () => _showEditScreen(context, todo),
                    child: const Text('Edit Todo'),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: FilledButton(
                    style: roundedRectangleButtonStyle.copyWith(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.errorContainer,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    child: const Text('Delete Todo'),
                    onPressed: () =>
                        _deleteButtonClick(context, controller),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: roundedRectangleButtonStyle.copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                onPressed: () {
                  controller.toggleDone();
                },
                child: Text('Mark as ${todo.done ? "Not Done" : "Done"}'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return Scaffold(body: Text(error.toString()));
  }

  Widget _onLoading() {
    return const Scaffold(body: CircularProgressIndicator());
  }

  void _showEditScreen(BuildContext context, Todo todo) {Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => TodoEditScreen(todo),
    ));
  }

  void _deleteButtonClick(
    BuildContext context,
    TodoDetailController todoController,
  ) {
    showDialog<bool>(
      context: context,
      builder: (context) => DeleteDialog(
        onDeleteClick: () {
          todoController.deleteTodo();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
