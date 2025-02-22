import 'package:employees/core/common/styles.dart';
import 'package:employees/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            context.goNamed(Routes.employees.name);
          });
        }

        return Scaffold(
          key: ValueKey<String>('splash_view'),
          backgroundColor: Styles.colors.blue,
          body: Center(
            child: SvgPicture.asset(
              key: ValueKey<String>('splash_view_logo'),
              Styles.assets.logo,
              colorFilter: ColorFilter.mode(
                Styles.colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );
  }
}
