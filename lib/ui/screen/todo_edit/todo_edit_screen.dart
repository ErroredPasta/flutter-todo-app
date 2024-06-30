import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_edit/widget/edit_screen_date_time_section.dart';
import 'package:todo_app/ui/screen/todo_edit/widget/edit_screen_note_section.dart';

import '../../../domain/domain_layer.dart';
import '../../ui_layer.dart';

class TodoEditScreen extends ConsumerWidget {
  final Todo todo;

  const TodoEditScreen(this.todo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoToEdit = ref.watch(todoEditControllerProvider(todo));
    final todoEditController =
        ref.watch(todoEditControllerProvider(todo).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: todoToEdit.title,
              decoration: const InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (title) => todoEditController.title = title,
            ),
            const SizedBox(height: 32),
            EditScreenNoteSection(
              todoToEdit.note,
              onNoteChange: (note) => todoEditController.note = note,
            ),
            const SizedBox(height: 32),
            EditScreenDateTimeSection(
              todoToEdit.dateTime,
              onDateTimeChange: (dateTime) =>
                  todoEditController.dateTime = dateTime,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: roundedRectangleButtonStyle,
                onPressed: () {
                  todoEditController
                      .editTodo()
                      .then((_) => context.pop());
                },
                child: const Text('Edit Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
