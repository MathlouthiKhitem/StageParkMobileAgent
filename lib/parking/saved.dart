import 'package:flutter/material.dart';

class SavedInterface extends StatefulWidget {
  @override
  _SavedInterfaceState createState() => _SavedInterfaceState();
}

class _SavedInterfaceState extends State<SavedInterface> {
  final List<ParkingInfo> savedParkingList = [
    ParkingInfo('Parking 1', 'Zone A'),
    ParkingInfo('Parking 2', 'Zone B'),
    ParkingInfo('Parking 3', 'Zone C'),
    ParkingInfo('Parking 3', 'Zone C'),
    ParkingInfo('Parking 3', 'Zone C'),
    ParkingInfo('Parking 3', 'Zone C'),
  ];

  List<ParkingInfo> filteredParkingList = [];

  @override
  void initState() {
    filteredParkingList.addAll(savedParkingList);
    super.initState();
  }

  void filterParkingList(String query) {
    setState(() {
      filteredParkingList = savedParkingList.where((parking) {
        final parkingName = parking.parkingName.toLowerCase();
        final zoneName = parking.zoneName.toLowerCase();
        final lowerCaseQuery = query.toLowerCase();
        return parkingName.contains(lowerCaseQuery) ||
            zoneName.contains(lowerCaseQuery);
      }).toList();
    });
  }

  void deleteSavedParking(int index) {
    setState(() {
      savedParkingList.removeAt(index);
      filteredParkingList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            width: 100,
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(90, 0, 30, 60),
            child: Row(
              children: [
                Icon(Icons.bookmark, size: 24),
                SizedBox(width: 10),
                Text(
                  'My Bookmark',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Container(
            width: 500,
            height: 50,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    // Handle clear button press
                  },
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredParkingList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    child: ListTile(
                      title: Text(filteredParkingList[index].parkingName),
                      subtitle: Text(filteredParkingList[index].zoneName),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteSavedParking(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ParkingSearchDelegate extends SearchDelegate<String> {
  final _SavedInterfaceState savedInterfaceState;

  ParkingSearchDelegate(this.savedInterfaceState);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    savedInterfaceState.filterParkingList(query);
    return Container(); // You can customize the search results view here
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // You can customize the search suggestions view here
  }
}

class ParkingInfo {
  final String parkingName;
  final String zoneName;

  ParkingInfo(this.parkingName, this.zoneName);
}
