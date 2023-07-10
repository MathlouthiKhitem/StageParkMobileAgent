import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parkmobile/navigations/notf.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../main.dart';
class CountdownProgressIndicator extends StatefulWidget {
  final int durationInSeconds;
  final Function() onTimerComplete;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  CountdownProgressIndicator({
    required this.durationInSeconds,
    required this.onTimerComplete,
    required this.flutterLocalNotificationsPlugin,
  });

  @override
  _CountdownProgressIndicatorState createState() =>
      _CountdownProgressIndicatorState();
}

class _CountdownProgressIndicatorState extends State<CountdownProgressIndicator> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          widget.onTimerComplete();
        }
      });
    });

    _scheduleNotification(); // Schedule the automatic notification
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Replace with your desired channel ID
      'your_channel_name', // Replace with your desired channel name
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await widget.flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Notification Title', // Title of the notification
      'Notification Body', // Body of the notification
      platformChannelSpecifics, // Notification details
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SleekCircularSlider(
            appearance: CircularSliderAppearance(
              customColors: CustomSliderColors(
                progressBarColors: [
                  Colors.deepPurpleAccent,
                  _remainingSeconds <= 10 ? Colors.redAccent : Colors.lightBlueAccent,
                ],
                trackColor: Colors.grey,
              ),
              infoProperties: InfoProperties(
                modifier: (double value) {
                  // Convert the remaining seconds to hours, minutes, and seconds
                  int hours = _remainingSeconds ~/ 3600;
                  int minutes = (_remainingSeconds % 3600) ~/ 60;
                  int seconds = _remainingSeconds % 60;

                  // Display the remaining time in the center of the slider
                  return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
                },
                mainLabelStyle: const TextStyle(fontSize: 20),
              ),
            ),
            min: 0,
            max: widget.durationInSeconds.toDouble(),
            initialValue: _remainingSeconds.toDouble(),
            onChange: (double value) {},
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Parking Area :',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Parking Lot of San Manolia',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Text(
                    'Address :',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 80),
                  Text(
                    '9569, Trantow Courts',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Text(
                    'Car',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 100),
                  Text(
                    ' (AF 4793 JU)',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Text(
                    'Duration :',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 80),
                  Text(
                    '4 hours',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Text(
                    'Hours :',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 80),
                  Text(
                    '09.00 AM - 13.00 PM',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 90),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF999CF0), // Set the background color
              // Set the text color
            ),
            child: const Text("Extend Parking Time"),
            onPressed: () {
              // Handle button press
            },
          ),
        ),
      ],
    );
  }
}

