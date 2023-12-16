import 'package:http/http.dart' as http;
import 'package:vms_admin/Model/read_visitor_model.dart';
import 'dart:convert';

class ReadVisitorService {
  final String baseUrl = 'http://z-pass.in/visitor_details/readAll.php';
  final String apiKey = '23rt2htfgi3gf38yhr5483hgui3htf8y3hgt83yg8yu'; // Assuming this is how you use your API key

  Future<List<ReadVisitorModel>> fetchVisitors() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {'X-API-Key': apiKey});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<ReadVisitorModel> visitors = body.map((dynamic item) => ReadVisitorModel.fromJson(item)).toList();
      return visitors;
    } else {
      throw Exception('Failed to load visitors');
    }
  }
}
