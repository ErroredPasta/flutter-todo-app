import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_edit/todo_edit_screen.dart';
import 'package:todo_app/ui/util/date_time_formatter.dart';

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
                    onPressed: () {},
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
                onPressed: () {},
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
}

class DetailScreenDateTimeSection extends StatelessWidget {
  final DateTime dateTime;

  const DetailScreenDateTimeSection(this.dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Due Date',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(formatDateTime(dateTime))
      ],
    );
  }
}

class DetailScreenNoteSection extends StatelessWidget {
  final String? noteContent;

  const DetailScreenNoteSection(this.noteContent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Note',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(noteContent != null ? noteContent! : 'No note')
      ],
    );
  }
}
