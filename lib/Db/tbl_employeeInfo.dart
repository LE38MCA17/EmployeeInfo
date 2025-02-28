
import 'dart:developer';

import '../model/employeeInfoModel.dart';
import 'database_helper.dart';


class Tbl_EmployeeInfo {

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> insertData(EmployeeInfoModel data) async {
    final db = await databaseHelper.openDatabase1();
    await db.insert('employees',  data.toJson());
  }

  Future<List<EmployeeInfoModel>> getAllData() async {
    final db = await databaseHelper.openDatabase1();
    List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT * FROM  employees;
    ''');
    print('fetchData getAllData $results');
    List<EmployeeInfoModel> list = results.map((map) {
      return EmployeeInfoModel.fromJson(map);
    }).toList();
    return list;
  }

  Future<void> clearTable() async {
    final db = await databaseHelper.openDatabase1();
    await db.execute('DELETE FROM employees');
    log('All employee records deleted');
  }



}
