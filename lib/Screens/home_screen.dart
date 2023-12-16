import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vms_admin/Screens/employee_screen.dart';
import 'package:vms_admin/Screens/profile_screen.dart';
import 'package:vms_admin/Screens/visitors_screen.dart';
import 'package:vms_admin/Widgets/checkout_search.dart';
import 'package:vms_admin/Widgets/stat_card.dart';
import 'package:vms_admin/Widgets/user_profile.dart';
import 'package:vms_admin/Widgets/visitor_listtile.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _formattedTime = '';

  void _getTime() {
    final String formattedDateTime = _formatDateTime(DateTime.now());
    setState(() {
      _formattedTime = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
  @override
  void initState() {
    super.initState();
    _formattedTime = _formatDateTime(DateTime.now());
    // Update time every minute
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CheckOutSearch());
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Handle check out action
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https://media.istockphoto.com/id/1354898581/photo/shot-of-a-young-businessman-using-a-laptop-in-a-modern-office.jpg?s=612x612&w=0&k=20&c=dDDNcvIoG-4VdO01ZlENqODBoNocT434vIFp0duuTZM='), // Replace with your asset image
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                // Navigate to Dashboard
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                        ProfileScreen())); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Employees'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                        EmployeeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Visitors'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                        VisitorScreen()));// close the drawer

              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Pre-registers'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                // Navigate to Pre-registers
              },
            ),
            // Add more ListTile widgets for other drawer items
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(_formattedTime),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _formattedTime = _formatDateTime(DateTime.now());
                  });
                },
                child: Text('Check in'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                shrinkWrap: true, // Use it to make GridView inside SingleChildScrollView
                physics: NeverScrollableScrollPhysics(),
                children: [
                  StatCard(title: 'Total Employees', count: 5, icon: Icons.people, color: Colors.red),
                  StatCard(title: 'Total Visitors', count: 12, icon: Icons.person, color: Colors.blue),
                  StatCard(title: 'Total Pre Registers', count: 10, icon: Icons.list, color: Colors.orange),
                ],
              ),
            ),

            SizedBox(
                height: 500,
                child: VisitorListScreen()
              ),
            SizedBox(
                height: 300,
                child: UserProfileSection())
          ],
        ),
      ),
    );
  }
}