import 'package:flutter/foundation.dart';
import 'package:vms_admin/Model/read_employee_model.dart';
import 'package:vms_admin/Services/read_employee_service.dart';

class EmployeeProvider with ChangeNotifier {
  ReadEmployeeService _employeeService = ReadEmployeeService();
  List<ReadEmployeeModel> _employee = [];

  List<ReadEmployeeModel> get employee => _employee;

  Future<void> loadVisitors() async {

    try {
      _employee = await _employeeService.fetchVisitors();
    } catch (e) {
      print('Error fetching employee: $e');
    } finally {
      notifyListeners();
    }
  }
}
