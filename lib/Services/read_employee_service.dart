import 'package:http/http.dart' as http;
import 'package:vms_admin/Model/read_employee_model.dart';
import 'dart:convert';

class ReadEmployeeService {
  final String baseUrl = 'http://z-pass.in/employee_details/readAll.php';
  final String apiKey = '23rt2htfgi3gf38yhr5483hgui3htf8y3hgt83yg8yu';

  Future<List<ReadEmployeeModel>> fetchEmployee() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: {'X-API-Key': apiKey});
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ReadEmployeeModel> employees = body.map((dynamic item) => ReadEmployeeModel.fromJson(item)).toList();
        print("Success to fetch Employee");
        return employees;
      } else {
        print("Failed to fetch Employee");
        throw Exception('Failed to load employee');
      }
    } catch (e) {
      print("Error in fetchEmployee: $e");
      rethrow;
    }
  }

}
