import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteDialog extends StatelessWidget {
  final void Function() onDeleteClick;

  const DeleteDialog({super.key, required this.onDeleteClick});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Todo'),
      content: const Text('Really want to delete?'),
      actions: [
        TextButton(
          onPressed: () {
            onDeleteClick();
            context.pop();
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
