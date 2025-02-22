extension StringExtension on String {
  String get formatedPhone {
    final ddi = '+${substring(0, 2)}';
    final ddd = '(${substring(2, 4)})';
    final number = '${substring(4, 9)}-${substring(9)}';

    return '$ddi $ddd $number';
  }
}
