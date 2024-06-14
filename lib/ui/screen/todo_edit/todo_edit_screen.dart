import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/ui/component/rounded_rectangle_button.dart';
import 'package:todo_app/ui/screen/todo_list_controller.dart';
import 'package:todo_app/ui/util/date_time_formatter.dart';

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
    final todoController = ref.read(todoListControllerProvider.notifier);

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
            const EditScreenNoteSection(),
            const SizedBox(height: 32),
            EditScreenDateTimeSection(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: roundedRectangleButtonStyle,
                onPressed: () {
                  _editTodo(
                    todoTitle,
                    todoNote,
                    todoDateTime,
                    todoController,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Edit Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editTodo(
    String title,
    String note,
    DateTime? dateTime,
    TodoListController controller,
  ) {
    controller.editTodo(
      widget.todo.copyWith(
        title: title,
        note: note.isEmpty ? null : note,
        dateTime: dateTime,
      ),
    );
  }
}

class EditScreenNoteSection extends ConsumerWidget {
  const EditScreenNoteSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoNote = ref.watch(_todoNote);

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
          initialValue: todoNote,
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

class EditScreenDateTimeSection extends ConsumerWidget {
  final _controller = TextEditingController();

  EditScreenDateTimeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
