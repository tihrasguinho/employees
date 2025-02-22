import 'package:employees/routing/routes.dart';
import 'package:employees/ui/view_models/employees_view_model.dart';
import 'package:employees/ui/views/employees_view.dart';
import 'package:employees/ui/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Routes.splash.path,
  routes: [
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      builder: (context, state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: Routes.employees.path,
      name: Routes.employees.name,
      builder: (context, state) {
        return EmployeesView(vm: context.read<EmployeesViewModel>());
      },
    ),
  ],
);
