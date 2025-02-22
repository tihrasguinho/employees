import 'package:employees/core/common/styles.dart';
import 'package:flutter/material.dart';

class EmployeeDetail extends StatelessWidget {
  const EmployeeDetail({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Styles.texts.h2.copyWith(
            fontWeight: FontWeight.w500,
            color: Styles.colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Styles.texts.h3.copyWith(
              fontWeight: FontWeight.w400,
              color: Styles.colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
