import 'package:employees/core/common/constraints.dart';
import 'package:employees/core/common/styles.dart';
import 'package:flutter/material.dart';

class EmployeesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmployeesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: preferredSize.height + top,
      width: preferredSize.width,
      child: Padding(
        padding: EdgeInsets.only(top: top),
        child: Row(
          children: [
            SizedBox(width: Constraints.x2),
            CircleAvatar(
              backgroundColor: Styles.colors.gray05,
              radius: 28.0,
              child: Text(
                'CG',
                style: Styles.texts.h3.copyWith(color: Styles.colors.black),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_rounded),
            ),
            SizedBox(width: Constraints.x1),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(68.0);
}
