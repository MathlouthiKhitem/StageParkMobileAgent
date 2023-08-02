import 'package:flutter/material.dart';

import 'BackgroundParkingInterface.dart';

class ParkingSelectionScreen extends StatefulWidget {
  const ParkingSelectionScreen({super.key});

  @override
  _ParkingSelectionScreenState createState() => _ParkingSelectionScreenState();
}

class _ParkingSelectionScreenState extends State<ParkingSelectionScreen> {
  String selectedParking = 'Tunis';

  String selectedParking2 = 'P001';
  List<String> parkingOptions1 = ['Tunis', 'Gazala', 'Raoud'];
  List<String> parkingOptions = ['P001', 'P002', 'P003'];

  void goToBackgroundParkingPlace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BackgroundParkingPlace(selectedParking2, selectedParking),
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ListeMaticule(),
    //   ),
    // );
  }

  bool isCarColorRed = true; // Change this value based on the car color
  bool isCarColorGreen = true; // Change this value based on the car color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black), // Add border around the icon
                  ),
                  child: Icon(
                    isCarColorRed ? Icons.directions_car : Icons.monetization_on,
                    size: 56,
                    color: isCarColorRed ? Colors.red : Colors.blue,
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between the icon and text
                Text(
                  isCarColorRed ? "He didn't paye " : 'Payable',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Add border around the icon
                      ),
                      child: Icon(
                        isCarColorRed ? Icons.directions_car : Icons.monetization_on,
                        size: 56,
                        color: isCarColorRed ? Colors.green : Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10), // Add spacing between the icon and text
                    Text(
                      isCarColorRed ? ' He  paye' : 'Payable',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Add border around the icon
                      ),
                      child: Icon(
                        isCarColorRed ? Icons.warning : Icons.monetization_on,
                        size: 56,
                        color: isCarColorRed ? Colors.red : Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10), // Add spacing between the icon and text
                    Text(
                      isCarColorRed ? 'Time is Over' : 'Payable',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Add border around the icon
                      ),
                      child: Icon(
                        isCarColorRed ? Icons.warning : Icons.monetization_on,
                        size: 56,
                        color: isCarColorRed ? Colors.green : Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10), // Add spacing between the icon and text
                    Text(
                      isCarColorRed ? 'Time Is Not Over' : 'Payable',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ],
            ),
            const SizedBox(height: 100),
            DropdownButton<String>(
              value: selectedParking,
              onChanged: (String? newValue) {
                setState(() {
                  selectedParking = newValue!;
                });
              },
              items: parkingOptions1.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Zone $value'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedParking2,
              onChanged: (String? newValue) {
                setState(() {
                  selectedParking2 = newValue!;
                });
              },
              items: parkingOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Parking $value'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: goToBackgroundParkingPlace,
              child: const Text('Go to BackgroundParkingPlace'),
            ),
          ],
        ),
      ),
    );
  }
}
