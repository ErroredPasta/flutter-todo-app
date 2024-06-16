import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddScreenNoteSection extends ConsumerWidget {
  final void Function(String note) onNoteChange;

  const AddScreenNoteSection({super.key, required this.onNoteChange});

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
          onChanged: onNoteChange,
        ),
      ],
    );
  }
}