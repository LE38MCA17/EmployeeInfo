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


  Future<void> getEmployeesInfo() async {
    isLoading = true;
    notifyListeners();
    try {
      List<EmployeeInfoModel> list = await repository.getEmployeesInfo();
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
      fetchAllEmployees();
    } catch (e) {
      log('Error fetching employee info: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllEmployees() async {
    isLoading = true;
    notifyListeners();
    try {
      employees = await tblEmployeeInfo.getAllData();
      log('Fetched employees: ${jsonEncode(employees)}');
    } catch (e) {
      log('Error fetching employees from DB: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}