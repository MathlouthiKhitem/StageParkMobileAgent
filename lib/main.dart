import 'package:flutter/material.dart';
import 'package:parkmobile/parking/Home.dart';
import 'package:parkmobile/parking/SleekCircularSlider.dart';
import 'package:parkmobile/parking/info.dart';
import 'package:parkmobile/parking/saved.dart';
import 'package:parkmobile/users/creatNewPassword.dart';
import 'package:parkmobile/users/profile.dart';
import 'package:parkmobile/users/signin.dart';

import 'package:parkmobile/users/signup.dart';

import 'navigations/nav_bottom.dart';
import 'navigations/nav_tab.dart';
import 'users/editProfile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'ParkMobile',
     // home: Home(),
     //  home: SleekCircularSliderExample(),



      routes: {

        "/": (context) {
          return Signin();
        },
        "/signup": (context) {
          return Signup();
        },
        "/resetPwd": (context) {
          return CreatNewPassword();
        },
        "/home": (context) {
          return Home();
        },
        "/home/update": (context) {
          return EditProfilePage();
        },

        "/homeBottom": (context) {
          return NavigationBottom();
        },
        "/homeTab": (context) {
          return NavigationTab();
        },

        "/home/info": (context) {
            return Info();
          },
      "/home/SleekCircularSliderExample": (context) {
      return SleekCircularSliderExample();
      },


      },
    );
  }
}






