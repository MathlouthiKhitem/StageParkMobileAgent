import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import '../module/ParkingSessionDTO.dart';
import 'dart:async'; // Import the dart:async library

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ListeNotficationScreen extends StatefulWidget {
  @override
  _ListeNotficationScreen createState() => _ListeNotficationScreen();
}
class _ListeNotficationScreen extends State<ListeNotficationScreen> {
  List<ParkingSessionDTO> parkingSessions = [];
  Timer? notificationTimer; // Define the Timer object

  @override
  void initState() {
    super.initState();
    fetchDataS();
    startNotificationTimer();
  }

  @override
  void dispose() {
    super.dispose();
    notificationTimer?.cancel(); // Cancel the timer when the screen is disposed
  }
  Future<void> fetchDataS() async {
    const String baseUrl = "10.0.2.2:8080";
    http.Response response = await http.get(Uri.http(baseUrl,
        "/backend/Agent/agents/64c6768956a8477059db7fcc/parkings"));
    print("response$response");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        // Handle response as an array
        List<ParkingSessionDTO> fetchedTasks = [];

        for (var taskData in data) {
          ParkingSessionDTO task = ParkingSessionDTO(
            sessionId: taskData['sessionId'],
            matricule: taskData['matricule'],
            status: taskData['status'],
            endTime: taskData['endTime'].toString(),
            startTime: taskData['startTime'].toString(),
            // clientIds:taskData['clientIds'],
          );
          fetchedTasks.add(task);
        }

        setState(() {
          parkingSessions = fetchedTasks;
        });
      } else if (data is Map<String, dynamic>) {
        // Handle response as an object
        ParkingSessionDTO task = ParkingSessionDTO(
          sessionId: data['sessionId'],
          matricule: data['matricule'],
          status: data['status'],
          endTime: data['endTime'].toString(),
          startTime: data['startTime'].toString(),
          // clientIds:data['clientIds'],
        );

        setState(() {
          parkingSessions = [task];
        });
      } else {
        // Handle unexpected response format
        print("Invalid response format");
      }
    } else {
      // Handle HTTP request failure
      print("Request failed with status: ${response.statusCode}");
    }
  }

  void _showNotification(String sessionStatus) async {
    if (sessionStatus == 'Ended') {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', // Replace with a unique identifier for your notification channel
        'Channel Name', // Replace with a name for your notification channel
        importance: Importance.max,
        priority: Priority.high,
      );
      var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );
      final lastParkingSession = parkingSessions.last;
      // Define notificationTitle and notificationBody
      String notificationTitle = 'Session terminée';
      String notificationBody = 'La session de stationnement est terminée.';

      // Show the notification
      await flutterLocalNotificationsPlugin.show(
        0, // ID of the notification
        notificationTitle, // Title of the notification
        notificationBody, // Body of the notification
        platformChannelSpecifics, // Platform-specific notification details
      );
    }
  }
  void startNotificationTimer() {
    const duration = Duration(seconds: 60); // Set the duration to 60 seconds
    notificationTimer = Timer.periodic(duration, (Timer timer) {
      // This callback will be called every 60 seconds
      // Check the status of the last parking session and show the notification
      if (parkingSessions.isNotEmpty) {
        final lastParkingSession = parkingSessions.last;
        if (lastParkingSession.status == 'Ended') {
          _showNotification(lastParkingSession.status);
        }
      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Sessions'),
      ),
      // body: ListView.builder(
      //   itemCount: parkingSessions.length,
      //   itemBuilder: (context, index) {
      //     final parkingSession = parkingSessions[index];
      //     bool isEnded = parkingSession.status == 'Ended';
      //
      //     return ListTile(
      //       title: Text('Session ID: ${parkingSession.sessionId}'),
      //       subtitle: Text('Status: ${parkingSession.status}'),
      //       onTap: () {
      //         _showNotification(parkingSession.status); // Pass the status as an argument
      //       },
      //       // Add more UI elements for other details as needed
      //       trailing: isEnded ? Icon(Icons.check_circle, color: Colors.green) : null,
      //     );
      //   },
      // ),
    );
  }

}
