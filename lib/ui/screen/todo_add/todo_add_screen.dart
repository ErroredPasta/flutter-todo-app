import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_add/widget/add_screen_date_time_section.dart';
import 'package:todo_app/ui/screen/todo_add/widget/add_screen_note_section.dart';
import 'package:uuid/v4.dart';

import '../../../domain/domain_layer.dart';
import '../../ui_layer.dart';

final _todoTitle = StateProvider.autoDispose<String>(
  (ref) => '',
);

final _todoNote = StateProvider.autoDispose<String>(
  (ref) => '',
);

final _todoDateTime = StateProvider.autoDispose<DateTime?>(
  (ref) => null,
);

class TodoAddScreen extends ConsumerWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoController = ref.watch(todoListControllerProvider.notifier);
    final todoTitle = ref.watch(_todoTitle);
    final todoNote = ref.watch(_todoNote);
    final todoDateTime = ref.watch(_todoDateTime);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
              onChanged: (value) => ref.read(_todoTitle.notifier).state = value,
            ),
            const SizedBox(height: 32),
            AddScreenNoteSection(
              onNoteChange: (note) => ref.read(_todoNote.notifier).state = note,
            ),
            const SizedBox(height: 32),
            AddScreenDateTimeSection(
              todoDateTime,
              onDateTimeChange: (dateTime) =>
                  ref.read(_todoDateTime.notifier).state = dateTime,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: roundedRectangleButtonStyle,
                onPressed: () {
                  _submitTodo(
                    todoTitle,
                    todoNote,
                    todoDateTime,
                    todoController,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Add Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTodo(
    String title,
    String note,
    DateTime? dateTime,
    TodoListController controller,
  ) {
    controller.addTodo(Todo(
      id: const UuidV4().generate(),
      title: title,
      note: note.isEmpty ? null : note,
      dateTime: dateTime,
    ));
  }
}
