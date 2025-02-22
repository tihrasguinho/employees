import 'package:employees/core/common/result.dart';
import 'package:employees/data/repositories/employees_repository.dart';
import 'package:employees/domain/models/employee_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EmployeesMockRepositoryImp extends Mock implements EmployeesRepository {}

final List<EmployeeModel> employees = [
  EmployeeModel(
    id: '1',
    name: 'John',
    job: 'Manager',
    admissionDate: DateTime.now(),
    phone: '5551234567890',
    image: 'https://placehold.co/512/000000/FFFFFF.png?text=John',
  ),
  EmployeeModel(
    id: '2',
    name: 'Jane',
    job: 'Developer',
    admissionDate: DateTime.now(),
    phone: '5551234567890',
    image: 'https://placehold.co/512/000000/FFFFFF.png?text=Jane',
  ),
  EmployeeModel(
    id: '3',
    name: 'Bob',
    job: 'Designer',
    admissionDate: DateTime.now(),
    phone: '5551234567890',
    image: 'https://placehold.co/512/000000/FFFFFF.png?text=Bob',
  ),
];

final exception = 'Failed to load employees';

void main() {
  late EmployeesRepository repository;

  setUp(() {
    repository = EmployeesMockRepositoryImp();
  });

  test('Must return an error when repository fails', () async {
    when(() => repository.findMany()).thenAnswer((_) async => Result.error(exception));
    final result = await repository.findMany();
    expect(result.isError(), isTrue);
    expect(result.getError(), equals(exception));
  });

  test('Must return a list of employees', () async {
    when(() => repository.findMany()).thenAnswer((_) async => Result.ok(employees));
    final result = await repository.findMany();
    expect(result.isOk(), isTrue);
    expect(result.getOk(), containsAll(employees));
  });
}
