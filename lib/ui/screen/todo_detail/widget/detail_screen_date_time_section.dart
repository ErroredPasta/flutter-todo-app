import 'package:flutter/material.dart';

import '../../../util/date_time_formatter.dart';

class DetailScreenDateTimeSection extends StatelessWidget {
  final DateTime dateTime;

  const DetailScreenDateTimeSection(this.dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Due Date',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(formatDateTime(dateTime))
      ],
    );
  }
}
