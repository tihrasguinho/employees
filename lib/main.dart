import 'package:employees/core/common/snackbars.dart';
import 'package:employees/core/common/styles.dart';
import 'package:employees/data/repositories/employees_remote_repository.dart';
import 'package:employees/data/repositories/employees_repository.dart';
import 'package:employees/data/service/dio_service.dart';
import 'package:employees/data/service/http_service.dart';
import 'package:employees/routing/router.dart';
import 'package:employees/ui/view_models/employees_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  const baseURL = String.fromEnvironment('BASE_URL');

  runApp(
    MultiProvider(
      providers: [
        Provider<HttpService>(create: (_) => DioService(baseURL: baseURL)),
        Provider<EmployeesRepository>(
          create: (ctx) => EmployeesRemoteRepository(ctx.read<HttpService>()),
        ),
        ChangeNotifierProvider<EmployeesViewModel>(
          create: (ctx) => EmployeesViewModel(ctx.read()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Employees',
      routerConfig: router,
      theme: Styles.theme,
      builder: SnackBars.builder,
    );
  }
}
