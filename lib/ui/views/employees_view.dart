import 'package:employees/core/common/constraints.dart';
import 'package:employees/core/common/snackbars.dart';
import 'package:employees/core/common/styles.dart';
import 'package:employees/core/extensions/date_time_extension.dart';
import 'package:employees/core/extensions/string_extension.dart';
import 'package:employees/ui/view_models/employees_view_model.dart';
import 'package:employees/ui/widgets/employee_detail.dart';
import 'package:employees/ui/widgets/employees_app_bar.dart';
import 'package:flutter/material.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key, required this.vm});

  final EmployeesViewModel vm;

  @override
  Widget build(BuildContext context) {
    vm.findMany.execute();

    return ListenableBuilder(
      listenable: vm.listenable,
      builder: (_, _) {
        if (vm.findMany.result?.isError() ?? false) {
          SnackBars.error(
            vm.findMany.result?.getError() ??
                'Falha ao carregar os funcionários!',
          );
        }

        return Scaffold(
          key: ValueKey<String>('employees_view'),
          appBar: EmployeesAppBar(),
          body: switch (vm.findMany.running) {
            true => const Center(child: CircularProgressIndicator()),
            false => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Constraints.x3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: Constraints.x1),
                    Text(
                      'Funcionários',
                      style: Styles.texts.h1.copyWith(
                        color: Styles.colors.black,
                      ),
                    ),
                    const SizedBox(height: Constraints.x2),
                    TextField(
                      controller: vm.searchController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: Constraints.x1),
                          child: Icon(Icons.search_rounded),
                        ),
                        fillColor: Styles.colors.gray05,
                        filled: true,
                        hintText: 'Pesquisar',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Constraints.x9),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: switch (vm.searchController.text.isEmpty) {
                          true => null,
                          false => Padding(
                            padding: const EdgeInsets.only(
                              right: Constraints.x1,
                            ),
                            child: IconButton(
                              onPressed: () => vm.searchController.clear(),
                              icon: Icon(Icons.clear_rounded),
                            ),
                          ),
                        },
                      ),
                    ),
                    const SizedBox(height: Constraints.x2),
                    Container(
                      decoration: BoxDecoration(
                        color: Styles.colors.white,
                        borderRadius: BorderRadius.circular(Constraints.x1),
                        border: Border.all(color: Styles.colors.gray10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(Constraints.x2),
                            decoration: BoxDecoration(
                              color: Styles.colors.blue10,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Constraints.x1),
                                topRight: Radius.circular(Constraints.x1),
                              ),
                              border: Border(
                                bottom: BorderSide(color: Styles.colors.gray10),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Constraints.x7,
                                  child: Text('Foto', style: Styles.texts.h2),
                                ),
                                Text('Nome', style: Styles.texts.h2),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: Constraints.x2,
                                  ),
                                  child: CircleAvatar(
                                    radius: Constraints.custom(0.5),
                                    backgroundColor: Styles.colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (final employee in vm.employees)
                            Container(
                              decoration: BoxDecoration(
                                border: switch (employee == vm.employees.last) {
                                  true => null,
                                  false => Border(
                                    bottom: BorderSide(
                                      color: Styles.colors.gray10,
                                    ),
                                  ),
                                },
                              ),
                              child: ExpansionTile(
                                key: ValueKey<String>(employee.id),
                                shape: const Border(),
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: Constraints.x7,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            employee.image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(employee.name),
                                  ],
                                ),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                childrenPadding: EdgeInsets.symmetric(
                                  horizontal: Constraints.x2,
                                  vertical: Constraints.x1,
                                ),
                                iconColor: Styles.colors.blue,
                                children: [
                                  EmployeeDetail(
                                    label: 'Cargo',
                                    value: employee.job,
                                  ),
                                  EmployeeDetail(
                                    label: 'Data de Admissão',
                                    value: employee.admissionDate.ddmmyyy,
                                  ),
                                  EmployeeDetail(
                                    label: 'Telefone',
                                    value: employee.phone.formatedPhone,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          },
        );
      },
    );
  }
}
