import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vms_admin/Model/read_visitor_model.dart';
import 'package:vms_admin/Provider/read_visitor_provider.dart';
import 'package:vms_admin/Widgets/visitor_details_screen.dart';

class VisitorListScreen extends StatefulWidget {
  const VisitorListScreen({super.key});

  @override
  _VisitorListScreenState createState() => _VisitorListScreenState();
}

class _VisitorListScreenState extends State<VisitorListScreen> {
  // This method filters today's visitors from the provided list.
  List<ReadVisitorModel> getTodaysVisitors(List<ReadVisitorModel> visitors) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return visitors.where((visitor) {
      if (visitor.checkInTime == null || visitor.checkInTime.isEmpty) {
        return false;
      }
      try {
        DateTime checkInDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(visitor.checkInTime);
        return DateFormat('yyyy-MM-dd').format(checkInDateTime) == today;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Today\'s Visitors'),
            const SizedBox(width: 10),
            Consumer<VisitorProvider>(
              builder: (context, visitorProvider, _) {
                var todaysVisitors = getTodaysVisitors(visitorProvider.visitors);
                return CircleAvatar(
                  child: Text(todaysVisitors.length.toString()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<VisitorProvider>(context, listen: false).loadVisitors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            // Handle errors if any
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<VisitorProvider>(
              builder: (context, visitorProvider, _) {
                var todaysVisitors = getTodaysVisitors(visitorProvider.visitors);
                return ListView.builder(
                  itemCount: todaysVisitors.length,
                  itemBuilder: (context, index) {
                    var visitor = todaysVisitors[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisitorDetailScreen(visitor: visitor),
                          ),
                        );
                      },
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      title: Text(visitor.visitorName),
                      subtitle: Text(visitor.email),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
