import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
  class ProfileInterface extends StatefulWidget {
  const ProfileInterface({super.key});

  @override
  _ProfileInterfaceState createState() =>
  _ProfileInterfaceState();
  }

  class _ProfileInterfaceState extends State<ProfileInterface> {
  bool isDarkMode = false;
  final String _baseUrl = "10.0.2.2:8080";

  void toggleDarkMode(bool value) {
  setState(() {
  isDarkMode = value;
  });
   }
   @override
 initState()  {
     fetchUserProfile();

    super.initState();
  }
  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? idUser= prefs.getString("userId");
    http.get(Uri.http(_baseUrl, "/Backend/users/$idUser/profileusers"))
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileInterface()),
        );
      } else {
        // Handle non-200 status code
      }
    }).catchError((error) {
      // Handle any errors or exceptions
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('lib/images/Ellipse.png'),
            ),
            const SizedBox(height: 30),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.pushNamed(context, "/home/update");
                            // Handle button press
                          },
                        ),
                        const Text('Edit Profile'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        const Text('Settings'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        const Text('Favorites'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.photo),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        const Text('Photos'),
                      ],
                    ),
                    const SizedBox(height: 10),


                    Row(
                      children: [
                        const Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.brightness_4),
                              SizedBox(width: 10),
                              Text('Dark Theme'),
                            ],
                          ),
                        ),
                        Switch(
                          value: isDarkMode,
                          onChanged: toggleDarkMode,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        const Text('Notifications'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        const Text('Logout'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }
}
