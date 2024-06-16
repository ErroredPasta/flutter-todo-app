import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_detail/widget/delete_dialog.dart';
import 'package:todo_app/ui/screen/todo_detail/widget/detail_screen_date_time_section.dart';
import 'package:todo_app/ui/screen/todo_detail/widget/detail_screen_note_section.dart';
import 'package:todo_app/ui/screen/todo_edit/todo_edit_screen.dart';

import '../../../domain/domain_layer.dart';
import '../../ui_layer.dart';

late AutoDisposeStateProvider<Todo> _todo;

class TodoDetailScreen extends ConsumerStatefulWidget {
  final Todo todo;

  const TodoDetailScreen(this.todo, {super.key});

  @override
  ConsumerState<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends ConsumerState<TodoDetailScreen> {
  @override
  void initState() {
    super.initState();
    _todo = StateProvider.autoDispose((ref) => widget.todo);
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(_todo);
    final todoController = ref.watch(todoListControllerProvider.notifier);

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
                    onPressed: () => _showEditScreen(context, ref, todo),
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
                        _deleteButtonClick(context, todoController, todo.id),
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
                  todoController.toggleDone(todo).then(
                    (result) {
                      if (result) {
                        ref.read(_todo.notifier).state =
                            todo.copyWith(done: !todo.done);
                      }
                    },
                  );
                },
                child: Text('Mark as ${todo.done ? "Not Done" : "Done"}'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showEditScreen(BuildContext context, WidgetRef ref, Todo todo) {
    final editResult = Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => TodoEditScreen(todo),
    ));

    editResult.then((result) {
      if (result != null) ref.read(_todo.notifier).state = result;
    });
  }

  void _deleteButtonClick(
    BuildContext context,
    TodoListController todoController,
    String todoId,
  ) {
    showDialog<bool>(
      context: context,
      builder: (context) => DeleteDialog(
        onDeleteClick: () {
          todoController.deleteTodo(todoId);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
