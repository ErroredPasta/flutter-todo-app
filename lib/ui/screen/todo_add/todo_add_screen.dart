import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/ui/screen/todo_list_controller.dart';
import 'package:todo_app/ui/util/date_time_formatter.dart';
import 'package:uuid/v4.dart';

final _todoInput = StateProvider.autoDispose<String>(
  (ref) => '',
);

final _selectedDateProvider = StateProvider.autoDispose<DateTime?>(
  (ref) => null,
);

class TodoAddScreen extends ConsumerWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoController = ref.read(todoListControllerProvider.notifier);
    final selectedDate = ref.watch(_selectedDateProvider);
    final todoInput = ref.watch(_todoInput);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Todo',
              ),
              onChanged: (value) => ref.read(_todoInput.notifier).state = value,
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Text(
                  selectedDate == null
                      ? 'No Date Chosen'
                      : formatDateTime(selectedDate),
                ),
                const Spacer(),
                if (selectedDate != null)
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(_selectedDateProvider.notifier).state = null,
                    child: const Text('Delete Date'),
                  ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () => _pickDateTime(context, ref),
                  child: const Text('Choose Date'),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitTodo(todoInput, selectedDate, todoController);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  child: const Text('Add Todo'),
                )
              ],
            ),
          ],
        ),
      ),
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

    ref.read(_selectedDateProvider.notifier).state = pickedDate.add(Duration(
      hours: pickedTime.hour,
      minutes: pickedTime.minute,
    ));
  }

  void _submitTodo(
    String todo,
    DateTime? dateTime,
    TodoListController controller,
  ) {
    controller.addTodo(Todo(
      id: const UuidV4().generate(),
      todo: todo,
      dateTime: dateTime,
    ));
  }
}
