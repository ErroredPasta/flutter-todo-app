import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/util/date_time_formatter.dart';
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
    final todoController = ref.read(todoListControllerProvider.notifier);
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
            const AddScreenNoteSection(),
            const SizedBox(height: 32),
            const AddScreenDateTimeSection(),
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

class AddScreenNoteSection extends ConsumerWidget {
  const AddScreenNoteSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          minLines: 3,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText: 'Add Note',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => ref.read(_todoNote.notifier).state = value,
        ),
      ],
    );
  }
}

class AddScreenDateTimeSection extends ConsumerStatefulWidget {
  const AddScreenDateTimeSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddScreenDateTimeSectionState();
  }
}

class _AddScreenDateTimeSectionState
    extends ConsumerState<AddScreenDateTimeSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoDateTime = ref.watch(_todoDateTime);

    if (todoDateTime != null) _controller.text = formatDateTime(todoDateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          readOnly: true,
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Pick a Date',
            border: const OutlineInputBorder(),
            suffixIcon: todoDateTime == null
                ? IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () => _pickDateTime(context, ref),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        ref.read(_todoDateTime.notifier).state = null,
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDateTime(BuildContext context, WidgetRef ref) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (!context.mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedDate == null || pickedTime == null) return;

    ref.read(_todoDateTime.notifier).state = pickedDate.add(Duration(
      hours: pickedTime.hour,
      minutes: pickedTime.minute,
    ));
  }
}
