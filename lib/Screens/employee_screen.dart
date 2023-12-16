import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms_admin/Model/read_employee_model.dart';
import 'package:vms_admin/Provider/read_employee_provider.dart';


class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<ReadEmployeeModel> employee = [];

  TextEditingController _searchController = TextEditingController();
  List<ReadEmployeeModel> filteredEmployee = [];

  void _filterVisitors(String query) {
    setState(() {
      filteredEmployee = query.isEmpty
          ? employee
          : employee.where((employee) {
        final fullName = "${employee.firstName} ${employee.lastName}";
        return fullName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _employeeDataSource.updateData(filteredEmployee);
    });
  }

  _EmployeeDataSource _employeeDataSource = _EmployeeDataSource([]);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final visitorProvider = Provider.of<EmployeeProvider>(context, listen: false);
      visitorProvider.loadVisitors().then((_) {
        setState(() {
          employee = visitorProvider.employee;
          _employeeDataSource = _EmployeeDataSource(employee);
          filteredEmployee = employee;
        });
      });
    });
  }

  void _onSearchChanged() {
    _filterVisitors(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<EmployeeProvider>(context,listen: false);
    employee = visitorProvider.employee;
    _employeeDataSource = _EmployeeDataSource(employee);
    filteredEmployee = employee;
    return Scaffold(
      backgroundColor: Color(0xffc2ddf8),
      appBar: AppBar(
        backgroundColor: Color(0xff0d81f5),
        title: Text('Employees'),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.4,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: 'Search by name...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: Icon(Icons.search)
                ),
                onChanged: _filterVisitors,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xff90c3f6)),
              rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Image')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Gender')),
                // DataColumn(label: Text('Status')),

              ],
              source: _employeeDataSource,
            ),
            SizedBox(height: 200,),
            Text("© Copyright 2023. All Rights Reserved By Conglomerate Business Solutions Pvt Ltd")
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}

class _EmployeeDataSource extends DataTableSource {
  List<ReadEmployeeModel> employee;
  // final Function(int, String) updateStatusCallback;

  _EmployeeDataSource(
      this.employee,
      // this.updateStatusCallback
      );
  void updateData(List<ReadEmployeeModel> newVisitors) {
    employee = newVisitors;
    notifyListeners(); // This is crucial to refresh the table
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= employee.length) {
      throw "error";
    };
    final employees = employee[index];
    final fullName = "${employees.firstName} ${employees.lastName}";

    return DataRow.byIndex(
      color: MaterialStateColor.resolveWith((states) {
        return index.isEven?Colors.green.shade50:Colors.blue.shade50;
      }),
      index: index,
      cells: [
        DataCell(Text(employees.employeeId.toString())),
        DataCell(CircleAvatar(
          backgroundImage: NetworkImage('https://media.istockphoto.com/id/1354898581/photo/shot-of-a-young-businessman-using-a-laptop-in-a-modern-office.jpg?s=612x612&w=0&k=20&c=dDDNcvIoG-4VdO01ZlENqODBoNocT434vIFp0duuTZM='),
        )),
        DataCell(Text(fullName)),
        DataCell(Text(employees.email.toString())),
        DataCell(Text(employees.contactNumber.toString())),
        DataCell(Text(employees.gender.toString())),

      ],
    );
  }

  @override
  int get rowCount => employee.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;


}



