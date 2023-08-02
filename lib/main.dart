import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parkmobile/users/creatNewPassword.dart';
import 'package:parkmobile/users/signin.dart';
import 'package:parkmobile/users/signup.dart';
import 'package:parkmobile/widegt/Info.dart';

import 'Parkings/ParkingSelectionScreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the local notifications plugin for Android and iOS
  var initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
  var initializationSettingsIOS =  DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkMobile',
      // home: BackgroundParkingPlace(),
      // home: ParkingSelectionScreen(),
      debugShowCheckedModeBanner: false,
      //  home:BackgroundParkingPlace("Gazala","P002"),
      //home:Info(),
      routes: {
        // "/": (context) {
        //   return SplashScreen();
        // },
        "/": (context) {
          return const Signin();
        },
        "/signup": (context) {
          return const Signup();
        },
        "/resetPwd": (context) {
          return const CreatNewPassword();
        },
        "/ParkingSelectionScreen": (context) {
          return const ParkingSelectionScreen();
        },
        },

    );
  }
}
