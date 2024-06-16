import 'package:flutter/material.dart';

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
