
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:parkmobile/users/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  _CurvedNavigationBarDemoState createState() => _CurvedNavigationBarDemoState();


}

class _CurvedNavigationBarDemoState extends State<NavigationBottom> {
  int _currentIndex = 0;
  String userEmail = '';

  final List<Widget> _screens = [

   const ProfileInterface(),
  ];
  @override
  void initState() {
    super.initState();
    getUserEmail();
  }
  Future<void> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString("userEmail") ?? '';
      print(prefs.getString("userEmail"));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.white,
        color: const Color(0xFF999CF3),
        buttonBackgroundColor: const Color(0xFF4448AE),
        height: 50,

        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.bookmarks, size: 30, color: Colors.white),
          // Add more icons here
        ],
        onTap: (index)  {

          setState(() {

            _currentIndex = index;
          });
        },
      ),
    );
  }

}
