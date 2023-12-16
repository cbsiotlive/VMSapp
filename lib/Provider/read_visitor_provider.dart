import 'package:flutter/foundation.dart';
import 'package:vms_admin/Model/read_visitor_model.dart';
import 'package:vms_admin/Services/read_visitor_service.dart';

class VisitorProvider with ChangeNotifier {
  ReadVisitorService _visitorService = ReadVisitorService();
  List<ReadVisitorModel> _visitors = [];

  List<ReadVisitorModel> get visitors => _visitors;


  Future<void> loadVisitors() async {
    try {
      _visitors = await _visitorService.fetchVisitors();
    } catch (e) {
      print('Error fetching visitors: $e');
    } finally {
      notifyListeners();
    }
  }
}
