import 'package:employees/core/common/result.dart';
import 'package:employees/domain/models/employee_model.dart';

abstract interface class EmployeesRepository {
  AsyncResult<List<EmployeeModel>> findMany();
}
