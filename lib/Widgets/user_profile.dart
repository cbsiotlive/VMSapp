import 'package:flutter/material.dart';

class UserProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.blue,
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with your image URL.
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 8),
              Text(
                'John Doe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text('Admin'),
            ],
          ),
        ),
        Divider(color: Colors.grey),
        Row(
          children: <Widget>[
            Icon(Icons.email),
            SizedBox(width: 8),
            Text('admin@example.com'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Icon(Icons.phone),
            SizedBox(width: 8),
            Text('+15005550006'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text('Dhaka, Bangladesh'),
          ],
        ),
      ],
    );
  }
}