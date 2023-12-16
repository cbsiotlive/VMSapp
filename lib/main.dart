import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vms_admin/Provider/read_employee_provider.dart';
import 'package:vms_admin/Provider/read_visitor_provider.dart';
import 'package:vms_admin/Screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => VisitorProvider()),
          ChangeNotifierProvider(create: (context)=>EmployeeProvider()),
        ],
        child: MyApp(),
      ),
    );
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:  DashboardScreen(),
    );
  }
}


