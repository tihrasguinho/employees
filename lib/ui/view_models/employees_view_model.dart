import 'package:diacritic/diacritic.dart';
import 'package:employees/core/common/command.dart';
import 'package:employees/core/common/result.dart';
import 'package:employees/data/repositories/employees_repository.dart';
import 'package:employees/domain/models/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeesViewModel extends ChangeNotifier {
  final EmployeesRepository repository;

  final TextEditingController searchController = TextEditingController();

  final List<EmployeeModel> _employees = [];

  List<EmployeeModel> get employees {
    final query = removeDiacritics(searchController.text.toLowerCase());

    if (query.isEmpty) {
      return _employees;
    }

    return _employees.where((e) {
      final name = removeDiacritics(e.name.toLowerCase());

      final job = removeDiacritics(e.job.toLowerCase());

      final phone = removeDiacritics(e.phone.toLowerCase());

      return name.contains(query) ||
          job.contains(query) ||
          phone.contains(query);
    }).toList();
  }

  late final Command0<void> findMany;

  Listenable get listenable =>
      Listenable.merge([this, findMany, searchController]);

  EmployeesViewModel(this.repository) {
    findMany = Command0<void>(_findMany);
  }

  AsyncResult<void> _findMany() async {
    final result = await repository.findMany();

    return result.fold(
      (ok) {
        _employees.clear();
        _employees.addAll(ok);
        notifyListeners();
        return Ok(null);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
