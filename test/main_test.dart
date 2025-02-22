import 'package:employees/core/common/result.dart';
import 'package:employees/core/common/snackbars.dart';
import 'package:employees/core/common/styles.dart';
import 'package:employees/core/extensions/date_time_extension.dart';
import 'package:employees/core/extensions/string_extension.dart';
import 'package:employees/data/repositories/employees_repository.dart';
import 'package:employees/domain/models/employee_model.dart';
import 'package:employees/routing/router.dart';
import 'package:employees/ui/view_models/employees_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class EmployeesMockRepositoryImp extends Mock implements EmployeesRepository {}

final List<EmployeeModel> employees = [
  EmployeeModel(
    id: '1',
    name: 'John',
    job: 'Manager',
    admissionDate: DateTime.now(),
    phone: '5521988421913',
    image: 'https://placehold.co/512/000000/FFFFFF.png?text=John',
  ),
  EmployeeModel(
    id: '2',
    name: 'Jane',
    job: 'Developer',
    admissionDate: DateTime.now(),
    phone: '5585981913137',
    image: 'https://placehold.co/512/000000/FFFFFF.png?text=Jane',
  ),
  EmployeeModel(
    id: '3',
    name: 'Bob',
    job: 'Designer',
    admissionDate: DateTime.now(),
    phone: '5511234567890',
    image: 'https://placehold.co/512/000000/FFFFFF.png?text=Bob',
  ),
];

void main() {
  late Widget app;
  late EmployeesRepository repository;

  setUp(() {
    repository = EmployeesMockRepositoryImp();
    app = MultiProvider(
      providers: [
        Provider<EmployeesRepository>(create: (ctx) => repository),
        ChangeNotifierProvider<EmployeesViewModel>(
          create: (ctx) => EmployeesViewModel(ctx.read()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Employees',
        routerConfig: router,
        theme: Styles.theme,
        builder: SnackBars.builder,
      ),
    );
  });

  testWidgets('Complete flow from splash to employees list', (tester) async {
    when(
      () => repository.findMany(),
    ).thenAnswer((_) async => Result.ok(employees));

    await tester.binding.setSurfaceSize(const Size(390, 844));

    provideMockedNetworkImages(() async {
      await tester.pumpWidget(app);

      await tester.pumpAndSettle();

      // Checking the splash view
      final splashView = find.byKey(const ValueKey<String>('splash_view'));

      expect(splashView, findsOneWidget);

      // Checking the splash view logo
      final splashViewLogo = find.byKey(
        const ValueKey<String>('splash_view_logo'),
      );

      expect(splashViewLogo, findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 3));

      // Checking the employees view
      final employeesView = find.byKey(
        const ValueKey<String>('employees_view'),
      );

      expect(employeesView, findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 1));

      // Checking the title
      final employeesTitle = find.text('Funcionários');

      expect(employeesTitle, findsOneWidget);

      // Tapping on every employee to open details screen and closing it after
      for (var i = 0; i < employees.length; i++) {
        final employee = employees[i];

        final employeeName = find.text(employee.name);

        expect(employeeName, findsOneWidget);

        await tester.ensureVisible(employeeName);

        await tester.tap(employeeName);

        await tester.pumpAndSettle(Duration(seconds: 1));

        final jobKey = find.text('Cargo');

        expect(jobKey, findsOneWidget);

        final jobValue = find.text(employee.job);

        expect(jobValue, findsOneWidget);

        final admissionDateKey = find.text('Data de Admissão');

        expect(admissionDateKey, findsOneWidget);

        final admissionDateValue = find.text(employee.admissionDate.ddmmyyy);

        expect(admissionDateValue, findsOneWidget);

        final phoneKey = find.text('Telefone');

        expect(phoneKey, findsOneWidget);

        final phoneValue = find.text(employee.phone.formatedPhone);

        expect(phoneValue, findsOneWidget);

        await tester.ensureVisible(employeeName);

        await tester.tap(employeeName);

        await tester.pumpAndSettle(Duration(seconds: 1));
      }

      // Findind the search field
      final textField = find.byType(TextField);

      expect(textField, findsOneWidget);

      // Searching employee by name
      await tester.ensureVisible(textField);

      await tester.enterText(textField, 'john');

      await tester.pumpAndSettle(Duration(seconds: 1));

      final nameExpansionTiles = find.byType(ExpansionTile);

      expect(nameExpansionTiles, findsOneWidget);

      // Searching employee by job
      await tester.ensureVisible(textField);

      await tester.enterText(textField, 'designer');

      await tester.pumpAndSettle(Duration(seconds: 1));

      final jobExpansionTiles = find.byType(ExpansionTile);

      expect(jobExpansionTiles, findsOneWidget);

      // Searching employee by phone
      await tester.ensureVisible(textField);

      await tester.enterText(textField, '981913137');

      await tester.pumpAndSettle(Duration(seconds: 1));

      final phoneExpansionTiles = find.byType(ExpansionTile);

      expect(phoneExpansionTiles, findsOneWidget);
    });
  });
}
