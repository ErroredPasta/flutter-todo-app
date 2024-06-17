import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_edit/widget/edit_screen_date_time_section.dart';
import 'package:todo_app/ui/screen/todo_edit/widget/edit_screen_note_section.dart';

import '../../../domain/domain_layer.dart';
import '../../ui_layer.dart';

late AutoDisposeStateProvider<String> _todoTitle;
late AutoDisposeStateProvider<String> _todoNote;
late AutoDisposeStateProvider<DateTime?> _todoDateTime;

class TodoEditScreen extends ConsumerStatefulWidget {
  final Todo todo;

  const TodoEditScreen(this.todo, {super.key});

  @override
  ConsumerState<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends ConsumerState<TodoEditScreen> {
  @override
  void initState() {
    super.initState();

    final todo = widget.todo;

    _todoTitle = StateProvider.autoDispose((ref) => todo.title);
    _todoNote = StateProvider.autoDispose((ref) => todo.note ?? '');
    _todoDateTime = StateProvider.autoDispose((ref) => todo.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final todoTitle = ref.watch(_todoTitle);
    final todoNote = ref.watch(_todoNote);
    final todoDateTime = ref.watch(_todoDateTime);
    final todoController = ref.watch(todoListControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
              initialValue: todoTitle,
              decoration: const InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => ref.read(_todoTitle.notifier).state = value,
            ),
            const SizedBox(height: 32),
            EditScreenNoteSection(
              todoNote,
              onNoteChange: (note) => ref.read(_todoNote.notifier).state = note,
            ),
            const SizedBox(height: 32),
            EditScreenDateTimeSection(
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
                  final updateResult = _editTodo(
                    todoTitle,
                    todoNote,
                    todoDateTime,
                    todoController,
                  );

                  updateResult.then(
                    (result) => Navigator.of(context).pop(result),
                  );
                },
                child: const Text('Edit Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Todo?> _editTodo(
    String title,
    String note,
    DateTime? dateTime,
    TodoListController controller,
  ) async {
    final updatedTodo = widget.todo.copyWith(
      title: title,
      note: note.isEmpty ? null : note,
      dateTime: dateTime,
    );

    return await controller.editTodo(updatedTodo) ? updatedTodo : null;
  }
}
