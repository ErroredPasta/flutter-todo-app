String formatDateTime(DateTime dateTime) {
  final DateTime(:year, :month, :day, :hour, :minute) = dateTime;
  return '$year.$month.$day $hour:$minute';
}
