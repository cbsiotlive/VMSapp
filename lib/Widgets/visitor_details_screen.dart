import 'package:flutter/material.dart';
import 'package:vms_admin/Model/read_visitor_model.dart';

class VisitorDetailScreen extends StatelessWidget {
  final ReadVisitorModel visitor;

  VisitorDetailScreen({required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name: ${visitor.visitorName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Email: ${visitor.email}"),
            Text("Contact Number: ${visitor.contactNumber}"),
            Text("Company Name: ${visitor.companyName}"),
            Text("Check-In Time: ${visitor.checkInTime}"),
            Text("Check-Out Time: ${visitor.checkOutTime}"),
            Text("Host Name: ${visitor.hostName}"),
            Text("Purpose: ${visitor.purpose}"),
            Text("Checked Out: ${visitor.isCheckedOut == 1 ? 'Yes' : 'No'}"),
            Text("Created At: ${visitor.createdAt}"),
            Text("Updated At: ${visitor.updatedAt}"),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
