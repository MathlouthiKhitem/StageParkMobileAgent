import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parkmobile/parking/CountdownProgressIndicator.dart';
import 'package:parkmobile/parking/Home.dart';
import 'package:parkmobile/parking/SleekCircularSlider.dart';
import 'package:parkmobile/parking/info.dart';
import 'package:parkmobile/parking/saved.dart';
import 'package:parkmobile/users/creatNewPassword.dart';
import 'package:parkmobile/users/profile.dart';
import 'package:parkmobile/users/signin.dart';
import 'package:parkmobile/users/signup.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart';
import 'SplashScreen.dart';
import 'navigations/nav_bottom.dart';
import 'navigations/nav_tab.dart';
import 'navigations/notf.dart';
import 'users/editProfile.dart';
FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeTimeZones();

  AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,

  );

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log(response.payload.toString());
      }
  );

  log("Notifications: $initialized");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkMobile',
      // home: Home(),
      debugShowCheckedModeBanner: false,

    //  home: Notification(),
      routes: {
        "/": (context) {
          return SplashScreen();
        },
        "/signin": (context) {
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
        "/home/CountdownProgressIndicator": (context) {
          return CountdownProgressIndicator(
            durationInSeconds: 10,
            onTimerComplete: () {
              // Handle timer completion
            }, flutterLocalNotificationsPlugin: notificationsPlugin,
          );
        },
      },
    );
  }
}
