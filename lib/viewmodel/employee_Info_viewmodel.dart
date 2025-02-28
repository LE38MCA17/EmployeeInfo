import 'dart:convert';
import 'dart:developer';
import 'package:employeeinfoapplication/Db/tbl_employeeInfo.dart';
import 'package:flutter/material.dart';
import '../model/employeeInfoModel.dart';
import '../repository/repository.dart';


class EmployeeInfoViewModel extends ChangeNotifier {
  final Repository repository = Repository();
  bool isLoading = false;
  final Tbl_EmployeeInfo tblEmployeeInfo = Tbl_EmployeeInfo();
  List<EmployeeInfoModel> employees = [];
  List<EmployeeInfoModel> filteredEmployees = [];

  Future<void> getEmployeesInfo(context) async {
    isLoading = true;
    notifyListeners();
    try {
      await tblEmployeeInfo.clearTable();
      List<EmployeeInfoModel> list = await repository.getEmployeesInfo(context);
      log('+++list ${jsonEncode(list)}');

      if (list.isNotEmpty) {
        for (var employee in list) {
          try {
            await tblEmployeeInfo.insertData(employee);
          } catch (e) {
            log('Error inserting employee: $e');
          }
        }
      }
      fetchAllEmployees(context);
    } catch (e) {
      log('Error fetching employee info: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllEmployees(context) async {
    isLoading = true;
    notifyListeners();

    try {
      employees = await tblEmployeeInfo.getAllData();
      if (employees.toString() == "[]") {
        await getEmployeesInfo(context);
      }
      filteredEmployees = employees;
      log('Fetched employees: ${jsonEncode(employees)}');
    } catch (e) {
      log('Error fetching employees from DB: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchEmployees(String query) {
    if (query.isEmpty) {
      filteredEmployees = employees;
    } else {
      filteredEmployees = employees
          .where((employee) =>
      employee.name.toLowerCase().contains(query.toLowerCase()) ||
          employee.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
