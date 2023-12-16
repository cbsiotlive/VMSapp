import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms_admin/Model/read_visitor_model.dart';
import 'package:vms_admin/Provider/read_visitor_provider.dart';

class VisitorScreen extends StatefulWidget {
  @override
  _VisitorScreenState createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  List<ReadVisitorModel> visitors = [];

  TextEditingController _searchController = TextEditingController();
  List<ReadVisitorModel> filteredVisitors = [];

    // void _updateStatus(int index, String newStatus) {
    //   setState(() {
    //     _visitorDataSource.visitors[index]['status'] = newStatus;
    //     _visitorDataSource.notifyListeners();
    //   });
    // }


    void _filterVisitors(String query) {
      setState(() {
        filteredVisitors = query.isEmpty
            ? visitors
            : visitors.where((visitor) => visitor.visitorName.toLowerCase().contains(query.toLowerCase())).toList();
        _visitorDataSource.updateData(filteredVisitors);
      });
    }



      _VisitorDataSource _visitorDataSource = _VisitorDataSource([]);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final visitorProvider = Provider.of<VisitorProvider>(context, listen: false);
      visitorProvider.loadVisitors().then((_) {
        setState(() {
          visitors = visitorProvider.visitors;
          _visitorDataSource = _VisitorDataSource(visitors);
          filteredVisitors = visitors;
        });
      });
    });
  }

  void _onSearchChanged() {
    _filterVisitors(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<VisitorProvider>(context,listen: false);
     visitors = visitorProvider.visitors;
    _visitorDataSource = _VisitorDataSource(visitors);
    filteredVisitors = visitors;
    return Scaffold(
      backgroundColor: Color(0xffc2ddf8),
      appBar: AppBar(
        backgroundColor: Color(0xff0d81f5),
        title: Text('Visitors'),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: 'Search by name...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(8),
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
                DataColumn(label: Text('Check In')),
                DataColumn(label: Text('Check Out')),
                // DataColumn(label: Text('Status')),

              ],
              source: _visitorDataSource,
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

class _VisitorDataSource extends DataTableSource {
   List<ReadVisitorModel> visitors;
  // final Function(int, String) updateStatusCallback;

  _VisitorDataSource(
      this.visitors,
      // this.updateStatusCallback
      );
   void updateData(List<ReadVisitorModel> newVisitors) {
     visitors = newVisitors;
     notifyListeners(); // This is crucial to refresh the table
   }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= visitors.length) {
      throw "error";
    };
    final visitor = visitors[index];

    return DataRow.byIndex(
      color: MaterialStateColor.resolveWith((states) {
        return index.isEven?Colors.green.shade50:Colors.blue.shade50;
      }),
      index: index,
      cells: [
        DataCell(Text(visitor.id.toString())),
        DataCell(CircleAvatar(
          backgroundImage: NetworkImage('https://media.istockphoto.com/id/1354898581/photo/shot-of-a-young-businessman-using-a-laptop-in-a-modern-office.jpg?s=612x612&w=0&k=20&c=dDDNcvIoG-4VdO01ZlENqODBoNocT434vIFp0duuTZM='),
        )),
        DataCell(Text(visitor.visitorName)),
        DataCell(Text(visitor.email)),
        DataCell(Text(visitor.contactNumber)),
        DataCell(
          visitor.checkInTime != null && visitor.checkInTime.contains(' ') ?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(visitor.checkInTime.split(' ')[0]), // Date
              Text(visitor.checkInTime.split(' ')[1]), // Time
            ],
          ) :
          Text(visitor.checkInTime ?? 'N/A'), // Fallback for null or unexpected format
        ),
        DataCell(
          visitor.checkOutTime != null && visitor.checkOutTime.contains(' ') ?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(visitor.checkOutTime.split(' ')[0]), // Date
              Text(visitor.checkOutTime.split(' ')[1]), // Time
            ],
          ) :
          Text(visitor.checkOutTime ?? 'N/A'), // Fallback for null or unexpected format
        ),

        // DataCell(
        //   visitor['status'] == 'Pending'
        //       ? _buildPendingDropDown(index)
        //       : _buildStatusButton(visitor['status']),
        // ),
        // DataCell for 'Actions' column can include PopupMenuButton or IconButton
      ],
    );
  }

  @override
  int get rowCount => visitors.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
  // Widget _buildStatusButton(String status) {
  //   Color color = _getStatusColor(status);
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: color,
  //           foregroundColor: Colors.white
  //     ),
  //     onPressed: () {},
  //     child: Text(status),
  //   );
  // }

  // Widget _buildPendingDropDown(int index) {
  //   return PopupMenuButton<String>(
  //     onSelected: (String newValue) {
  //       updateStatusCallback(index, newValue);
  //     },
  //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
  //       PopupMenuItem<String>(
  //         value: 'Accepted',
  //         child: Text('Accept'),
  //       ),
  //       PopupMenuItem<String>(
  //         value: 'Rejected',
  //         child: Text('Reject'),
  //       ),
  //     ],
  //     child: Container(
  //       height: 45,
  //       width: 100,
  //       decoration: BoxDecoration(
  //         color: _getStatusColor('Pending'),
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //           width: 1,
  //           color: Colors.black
  //         )
  //       ),
  //       child:  Row(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text('Pending'),
  //         Icon(Icons.arrow_drop_down),
  //       ],
  //     ),
  //     ),
  //   );
  // }


  Color _getStatusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.grey.shade200;
      default:
        return Colors.black;
    }
  }

}



