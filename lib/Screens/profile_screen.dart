import 'package:flutter/material.dart';
import 'package:vms_admin/Widgets/change_password.dart';
import 'package:vms_admin/Widgets/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Form keys
  final _passwordFormKey = GlobalKey<FormState>();
  final _editProfileFormKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc2ddf8),
      appBar: AppBar(
        backgroundColor: Color(0xff0d81f5),
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://media.istockphoto.com/id/1354898581/photo/shot-of-a-young-businessman-using-a-laptop-in-a-modern-office.jpg?s=612x612&w=0&k=20&c=dDDNcvIoG-4VdO01ZlENqODBoNocT434vIFp0duuTZM='), // Replace with your asset image
       // Replace with actual image URL
          ),
          SizedBox(height: 10),
          Text('Mr. Sangram Roygupta', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('sneider@cbsiot.live'),
          Divider(height: 20, thickness: 1),
          Text('Username: sneider123'),
          Text('Phone: 6296878926'),
          Text('Address: Kolkata, West Bengal'),
          Divider(height: 20, thickness: 1),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                ChangePasswordForm(_passwordFormKey, _oldPasswordController, _passwordController, _confirmPasswordController)));
          },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                fixedSize: Size( 400, 200,)
              ),
              child: Text("Change Password")),

          Divider(height: 20, thickness: 1),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
          },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                fixedSize: Size(400, 200)
              ),
              child: Text("Edit Profile"))
          // More widgets can be added here for additional profile sections
        ],
      ),
    );
  }
}