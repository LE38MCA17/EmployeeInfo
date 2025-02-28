import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:employeeinfoapplication/viewmodel/employee_Info_viewmodel.dart';

import 'employee_details_view.dart';

class EmployeeInfoView extends StatefulWidget {
  const EmployeeInfoView({Key? key}) : super(key: key);

  @override
  State<EmployeeInfoView> createState() => _EmployeeInfoViewState();
}

class _EmployeeInfoViewState extends State<EmployeeInfoView> {
  late EmployeeInfoViewModel _employeeInfoViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeInfoViewModel>(context, listen: false).getEmployeesInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _employeeInfoViewModel = context.watch<EmployeeInfoViewModel>();
    final employees = _employeeInfoViewModel.employees;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Employee List"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: employee.profileImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(
                employee.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Email: ${employee.email}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeDetailsPage(employee: employee),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
