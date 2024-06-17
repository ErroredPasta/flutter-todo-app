import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/date_time_formatter.dart';

class EditScreenDateTimeSection extends ConsumerWidget {
  final DateTime? dateTime;
  final void Function(DateTime?) onDateTimeChange;
  final _controller = TextEditingController();

  EditScreenDateTimeSection(this.dateTime,
      {super.key, required this.onDateTimeChange}) {
    if (dateTime != null) _controller.text = formatDateTime(dateTime!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            suffixIcon: dateTime == null
                ? IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () => _pickDateTime(context, ref),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        onDateTimeChange(null),
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

    if (pickedDate == null) return;

    if (!context.mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    onDateTimeChange(pickedDate.add(Duration(
      hours: pickedTime.hour,
      minutes: pickedTime.minute,
    )));
  }
}
