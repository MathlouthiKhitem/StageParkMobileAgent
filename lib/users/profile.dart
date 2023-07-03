import 'package:flutter/material.dart';


  class ProfileInterface extends StatefulWidget {
  const ProfileInterface({super.key});

  @override
  _ProfileInterfaceState createState() =>
  _ProfileInterfaceState();
  }

  class _ProfileInterfaceState extends State<ProfileInterface> {
  bool isDarkMode = false;

  void toggleDarkMode(bool value) {
  setState(() {
  isDarkMode = value;
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
            SizedBox(height: 30),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.pushNamed(context, "/home/update");
                            // Handle button press
                          },
                        ),
                        Text('Edit Profile'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        Text('Settings'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        Text('Favorites'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        Text('Photos'),
                      ],
                    ),
                    SizedBox(height: 10),


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

                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        Text('Notifications'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            // Handle button press
                          },
                        ),
                        Text('Logout'),
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
