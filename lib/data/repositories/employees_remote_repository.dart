import 'package:employees/core/common/result.dart';
import 'package:employees/data/service/http_service.dart';
import 'package:employees/domain/models/employee_model.dart';

import 'employees_repository.dart';

class EmployeesRemoteRepository implements EmployeesRepository {
  final HttpService http;

  EmployeesRemoteRepository(this.http);

  @override
  AsyncResult<List<EmployeeModel>> findMany() async {
    final result = await http.get('/employees');

    if (result.isError()) {
      return Error(result.getError());
    }

    final response = result.getOk();

    if (response.statusCode != 200) {
      return Error(
        'Failed to load employees. Status code: ${response.statusCode}',
      );
    }

    final body = response.data;

    if (body is! List) {
      return Error('Unexpected response: $body');
    }

    final employees = body.map((e) => EmployeeModel.fromMap(e)).toList();

    return Ok(employees);
  }
}
