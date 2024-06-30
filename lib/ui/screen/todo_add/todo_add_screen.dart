import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_add/widget/add_screen_date_time_section.dart';
import 'package:todo_app/ui/screen/todo_add/widget/add_screen_note_section.dart';

import '../../ui_layer.dart';

class TodoAddScreen extends ConsumerWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAddController = ref.watch(todoAddControllerProvider.notifier);
    final todo = ref.watch(todoAddControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('New Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (title) => todoAddController.title = title,
            ),
            const SizedBox(height: 32),
            AddScreenNoteSection(
              onNoteChange: (note) => todoAddController.note = note,
            ),
            const SizedBox(height: 32),
            AddScreenDateTimeSection(
              todo.dateTime,
              onDateTimeChange: (dateTime) =>
                  todoAddController.dateTime = dateTime,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: roundedRectangleButtonStyle,
                onPressed: () {
                  todoAddController
                      .addTodo()
                      .then((value) => context.pop());
                },
                child: const Text('Add Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
