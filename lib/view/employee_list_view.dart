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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<EmployeeInfoViewModel>(context, listen: false);
      await viewModel.fetchAllEmployees(); // Check if DB has data

      if (viewModel.employees.isEmpty) {
        await viewModel.getEmployeesInfo(); // Fetch from API if DB is empty
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _employeeInfoViewModel = context.watch<EmployeeInfoViewModel>();
    final employees = _employeeInfoViewModel.filteredEmployees;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Employee List"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name or email",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (query) {
                _employeeInfoViewModel.searchEmployees(query);
              },
            ),
          ),
          Expanded(
            child: _employeeInfoViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : employees.isEmpty
                ? const Center(child: Text("No employees found"))
                : ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: employee.profileImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        title: Text(
                          employee.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
