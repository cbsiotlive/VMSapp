import 'package:http/http.dart' as http;
import 'package:vms_admin/Model/read_employee_model.dart';
import 'dart:convert';

class ReadEmployeeService {
  final String baseUrl = 'http://z-pass.in/employee_details/readAll.php';
  final String apiKey = '23rt2htfgi3gf38yhr5483hgui3htf8y3hgt83yg8yu'; // Assuming this is how you use your API key

  Future<List<ReadEmployeeModel>> fetchVisitors() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {'X-API-Key': apiKey});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<ReadEmployeeModel> visitors = body.map((dynamic item) => ReadEmployeeModel.fromJson(item)).toList();
      return visitors;
    } else {
      throw Exception('Failed to load employee');
    }
  }
}
