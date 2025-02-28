
import 'package:employeeinfoapplication/model/employeeInfoModel.dart';
import '../constants/api_path_constants.dart';
import '../services/apiProvider.dart';


class Repository {

  final apiProvider = ApiProvider();


  Future<List<EmployeeInfoModel>> getEmployeesInfo(context) async {
    final response = await apiProvider.getCall(ApiNames.API_GET_EMPLOYEE_DETAILS_URL,context );
    print("hbjhbjh"+response.toString());
    final List<dynamic> jsonList = response;
    final List<EmployeeInfoModel> purchaseDetailsList = jsonList.map((json) => EmployeeInfoModel.fromJson(json)).toList();
    return purchaseDetailsList;
  }


}
