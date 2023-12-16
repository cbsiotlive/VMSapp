import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const StatCard({super.key, required this.title, required this.count, required this.icon, required this.color});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade50,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListTile(
        leading: Container(
            height: 50,
            width: 50,
            color: color,
            child: Icon(icon, size: 50.0,color: Colors.white,)),
        title: Text(title, style: TextStyle(color: Colors.black)),
        subtitle: Text('$count', style: TextStyle(fontSize: 20.0, color: Colors.black)),
      ),
    );
  }
}