import 'package:flutter/material.dart';

class CheckOutSearch extends SearchDelegate<String> {
  bool isSearchComplete = false;
  // Your data for the search
  final visitorIds = [
    'V123',
    'V456',
    'V789',
    // Add more visitor IDs
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the AppBar.
    return [
      IconButton(
        icon: !isSearchComplete?Icon(Icons.clear):Icon(Icons.search),
        onPressed: () {
          isSearchComplete?print('Selected visitor ID: $query'):query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the AppBar.
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show some result based on the selection
    isSearchComplete = true;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Selected visitor ID: $query'),
          ElevatedButton(
            onPressed: () {
              // Handle the action after the search is complete, for example:
              // Navigate to the visitor's detail page or perform a check-out.
              print("Check out Visitor with id: $query");
              Navigator.pop(context);
            },
            child: Text('Proceed with ID $query'),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone searches for something
    final suggestions = visitorIds.where((visitorId) {
      return visitorId.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}