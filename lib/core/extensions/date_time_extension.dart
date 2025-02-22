extension DateTimeExtension on DateTime {
  String get ddmmyyy {
    final d = day.toString().padLeft(2, '0');
    final m = month.toString().padLeft(2, '0');
    final y = year.toString();

    return '$d/$m/$y';
  }
}
