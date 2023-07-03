import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../navigations/nav_tab.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 70, 0, 100),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  _buildCard(
                    "Parking Area",
                    "Parking Lot of San Manolia",
                    "Address",
                    "9569, Trantow Courts",
                    "Parking Area",
                    "Parking Lot of San Manolia",
                    "Parking Area",
                    "Parking Lot of San Manolia",
                  ),
                  _buildCard(
                    "Parking Area",
                    "Parking Lot of San Manolia",
                    "Address",
                    "9569, Trantow Courts",
                    "Parking Area",
                    "Parking Lot of San Manolia",
                    "Parking Area",
                    "Parking Lot of San Manolia",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 370, // Set the desired width
              height: 50, // Set the desired height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF999CF0), // Set the background color
                  // Set the text color
                ),
                child: const Text("Confirm Payment"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationTab()),
                  );
                  // Navigator.pushNamed(context, "/homeTab");
                  // Handle button press
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      String title1,
      String value1,
      String title2,
      String value2,
      String title3,
      String value3,
      String title4,
      String value4,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value1,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value2,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title3,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value3,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title4,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value4,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
