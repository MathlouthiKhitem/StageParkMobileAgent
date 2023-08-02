import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';
import '../module/ParkingSessionDTO.dart';
class BackgroundParkingPlace extends StatefulWidget {
  final String selectedParking;
  final String selectedParking1;

  const BackgroundParkingPlace(this.selectedParking, this.selectedParking1, {super.key});

  @override
  _BackgroundParkingPlaceState createState() => _BackgroundParkingPlaceState();
}

class _BackgroundParkingPlaceState extends State<BackgroundParkingPlace> {
  List<Parkings> tasks = [];
  List<ParkingSessionDTO> parkingSessions = [];
  Timer? notificationTimer; // Define the Timer object
  @override
  void initState() {
    super.initState();
    fetchData();
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
      String notificationBody = "matricule" + ""
          +lastParkingSession.matricule;

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
      // Check the status of each parking session and show the notification for "Ended" sessions
      for (var parkingSession in parkingSessions) {
        if (parkingSession.status == 'Ended') {
          print(parkingSession.status == 'Ended');
          _showNotification(parkingSession.status);
        }
      }
    });
  }

  Future<void> fetchData() async {
    const String baseUrl = "10.0.2.2:8080";
    http.Response response = await http.get(Uri.http(baseUrl,
        "/backend/Agent/getClientIdAndStatusByParkingAndTitle/${widget.selectedParking}/${widget.selectedParking1}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        // Handle response as an array
        List<Parkings> fetchedTasks = [];

        for (var taskData in data) {
          Parkings task = Parkings(
            clientId: taskData['clientId'],
            matricule: taskData['matricule'],
            status: taskData['status'],
            endTime: taskData['endTime'],
          );
          fetchedTasks.add(task);
        }

        setState(() {
          tasks = fetchedTasks;
        });
      } else if (data is Map<String, dynamic>) {
        // Handle response as an object
        Parkings task = Parkings(
          clientId: data['clientId'],
          matricule: data['matricule'],
          status: data['status'],
          endTime: data['endTime'],
        );

        setState(() {
          tasks = [task];
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

  void refreshPage() {
    setState(() {
      tasks = [];
      fetchData();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Parkings>>(
        future: Future.delayed(const Duration(seconds: 2), () => tasks),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Parkings> taskList = snapshot.data!;
            return Stack(
              children: [
                Image.asset(
                  'lib/images/liste4.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                ...taskList.asMap().entries.map((entry) {
                  int index = entry.key;
                  Parkings task = entry.value;

                  ExpirationStatus expirationStatus =
                  getExpirationStatus(task.endTime ?? '');

                  IconData appleIcon;
                  Color appleColor;

                  switch (expirationStatus) {
                    case ExpirationStatus.Expired:
                      appleIcon = Icons.warning;
                      appleColor = Colors.red;
                      break;
                    case ExpirationStatus.Ongoing:
                      appleIcon = Icons.warning;
                      appleColor = Colors.green;
                      break;
                    case ExpirationStatus.Future:
                      appleIcon = Icons.warning;
                      appleColor = Colors.green;
                      break;
                  }

                  return Positioned(
                    top: _getTopPosition(index),
                    left: _getLeftPosition(index),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _showTextFieldDialog(context, task.matricule);
                          },
                          child: Transform.rotate(
                            angle: _getAngle(index) * 0.0174533,
                            child: _buildFloatingCar(task.status, task.matricule),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle button press
                          },
                          icon: Icon(
                            appleIcon,
                            color: appleColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(

                    onPressed: refreshPage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch tasks'));
          }
          return  const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  double _getTopPosition(int index) {
    switch (index) {
      case 0:
        return 117;
      case 1:
        return 390;
      case 2:
        return 530;
      case 3:
        return 136;
      case 4:
        return 512;
      case 5:
        return 620;
      case 6:
        return 200;
      default:
        return 0;
    }
  }

  double _getLeftPosition(int index) {
    switch (index) {
      case 0:
        return 50;
      case 1:
        return 50;
      case 2:
        return 50;
      case 3:
        return 270;
      case 4:
        return 270;
      case 5:
        return 270;
      case 6:
        return 80;
      default:
        return 0;
    }
  }

  double _getAngle(int index) {
    switch (index) {
      case 0:
        return 26;
      case 1:
        return 26;
      case 2:
        return 26;
      case 3:
        return -30;
      case 4:
        return -30;
      case 5:
        return -30;
      default:
        return 0;
    }
  }

  Widget _buildFloatingCar(bool? status, String? matricule) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: status == true ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_car,
              color: Colors.white,
            ),
            Text(
              matricule ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



enum ExpirationStatus {
  Expired,
  Ongoing,
  Future,
}

ExpirationStatus getExpirationStatus(String endTime) {
  DateTime now = DateTime.now();
  DateTime endTimeDateTime = DateTime.parse(endTime);
print(now);
  if (now.isAfter(endTimeDateTime)) {
    return ExpirationStatus.Expired;
  } else if (now.isBefore(endTimeDateTime)) {
    return ExpirationStatus.Future;
  } else {
    return ExpirationStatus.Ongoing;
  }
}
  double _getTopPosition(int index) {
    switch (index) {
      case 0:
        return 117;
      case 1:
        return 390;
      case 2:
        return 530;
      case 3:
        return 136;
      case 4:
        return 512;
      case 5:
        return 620;
      case 6:
        return 200;
      default:
        return 0;
    }
  }

  double _getLeftPosition(int index) {
    switch (index) {
      case 0:
        return 50;
      case 1:
        return 50;
      case 2:
        return 50;
      case 3:
        return 270;
      case 4:
        return 270;
      case 5:
        return 270;
      case 6:
        return 80;
      default:
        return 0;
    }
  }

  double _getAngle(int index) {
    switch (index) {
      case 0:
        return 26;
      case 1:
        return 26;
      case 2:
        return 26;
      case 3:
        return -30;
      case 4:
        return -30;
      case 5:
        return -30;
      default:
        return 0;
    }
  }

Widget _buildFloatingCar(bool? status, String? matricule) {
  return Container(
    width: 100,
    height: 50,
    decoration: BoxDecoration(
      color: status == true ? Colors.green : Colors.red,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.directions_car,
            color: Colors.white,
          ),
          Text(
            matricule ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}


class Parkings {
  final String? clientId;
  final String? matricule;
  final bool? status;
  final String? endTime;

  Parkings({this.clientId, this.matricule, this.status, this.endTime});
}




// class BackgroundParkingPlace extends StatefulWidget {
//   final String selectedParking;
//   final String selectedParking1;
//   BackgroundParkingPlace(this.selectedParking, this.selectedParking1);
//
//   @override
//   _BackgroundParkingPlaceState createState() => _BackgroundParkingPlaceState();
// }
//
// class _BackgroundParkingPlaceState extends State<BackgroundParkingPlace> {
//   late Future<List<Parkings>> _parkingsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _parkingsFuture = fetchData();
//   }
//
//   Future<List<Parkings>> fetchData() async {
//     final String _baseUrl = "10.0.2.2:8080";
//     http.Response response = await http.get(Uri.http(_baseUrl, "/backend/Agent/ParkingsByNumberOrZone/${widget.selectedParking}/${widget.selectedParking1}"));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List<Parkings> fetchedTasks = [];
//       for (var taskData in data) {
//         Parkings task = Parkings(
//           id: taskData['id'],
//           zoneTitle: taskData['zoneTitle'],
//           numeroParking: taskData['numeroParking'],
//         );
//         fetchedTasks.add(task);
//       }
//       return fetchedTasks;
//     } else {
//       throw Exception('Failed to fetch parkings');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Parkings>>(
//         future: _parkingsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Parkings> parkingsList = snapshot.data!;
//             return Stack(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _showTextFieldDialog(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 19),
//                     primary: Color(0xFF999CF0),
//                   ),
//                   child: const Text(
//                     'test',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//
//                 // Button
//                 Positioned(
//                   bottom: 20,
//                   right: 90,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ParkingSelectionScreen(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 90, vertical: 19),
//                       primary: Color(0xFF999CF0),
//                     ),
//                     child: const Text(
//                       'Continue',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Failed to fetch parkings'));
//           }
//           // Show a progress indicator while loading the data
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
//
//   double _getTopPosition(int index) {
//     switch (index) {
//       case 0:
//         return 117;
//       case 1:
//         return 390;
//       case 2:
//         return 530;
//       case 3:
//         return 136;
//       case 4:
//         return 512;
//       case 5:
//         return 620;
//       case 6:
//         return 200;
//       default:
//         return 0;
//     }
//   }
//
//   double _getLeftPosition(int index) {
//     switch (index) {
//       case 0:
//         return 50;
//       case 1:
//         return 50;
//       case 2:
//         return 50;
//       case 3:
//         return 270;
//       case 4:
//         return 270;
//       case 5:
//         return 270;
//       case 6:
//         return 80;
//       default:
//         return 0;
//     }
//   }
//
//   double _getAngle(int index) {
//     switch (index) {
//       case 0:
//         return 26;
//       case 1:
//         return 26;
//       case 2:
//         return 26;
//       case 3:
//         return -30;
//       case 4:
//         return -30;
//       case 5:
//         return -30;
//       default:
//         return 0;
//     }
//   }
//
//   Widget _buildFloatingCar(String parkingNumber) {
//     return Container(
//       width: 100,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Color(0xFF999CF0),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.directions_car,
//               color: Colors.white,
//             ),
//             Text(
//               parkingNumber,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showTextFieldDialog(BuildContext context) async {
//     String textFieldValue = '';
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('registration number'),
//           content: TextField(
//             onChanged: (value) {
//               textFieldValue = value;
//             },
//             decoration: const InputDecoration(hintText: 'registration number'),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 _consumeAPI(context, textFieldValue);
//               },
//               child: Text('Verify'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _consumeAPI(BuildContext context, String value) async {
//     final String _baseUrl = "10.0.2.2:8080";
//
//     List<dynamic> matriculeList = [value];
//     String jsonString = '{"matricule": [\n';
//     for (int i = 0; i < matriculeList.length; i++) {
//       jsonString += '  "${matriculeList[i]}"';
//       if (i != matriculeList.length - 1) {
//         jsonString += ',\n';
//       }
//     }
//     jsonString += '\n]}';
//
//     print(jsonString);
//
//     print(jsonString);
//
//     Map<String, String> headers = {
//       "Content-Type": "application/json; charset=UTF-8",
//     };
//
//
//       http.Response response = await http.post(
//         Uri.http(_baseUrl, "/backend/Agent/matricules"),
//         headers: headers,
//         body: jsonString,
//       );
//
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print(data);
//
//       }
//
//
//   }
// }
//
// class Parkings {
//   final String id;
//   final String zoneTitle;
//   final String numeroParking;
//
//   Parkings({
//     required this.id,
//     required this.zoneTitle,
//     required this.numeroParking,
//   });
// }
////lisy//
// ...taskList.asMap().entries.map((entry) {
// int index = entry.key;
// Parkings task = entry.value;
//
// ExpirationStatus expirationStatus = getExpirationStatus(task.endTime ?? '');
//
// IconData appleIcon;
// Color appleColor;
//
// switch (expirationStatus) {
// case ExpirationStatus.Expired:
// appleIcon = Icons.warning;
// appleColor = Colors.red;
// break;
// case ExpirationStatus.Ongoing:
// appleIcon = Icons.warning;
// appleColor = Colors.green;
// break;
// case ExpirationStatus.Future:
// appleIcon = Icons.warning;
// appleColor = Colors.blue;
// break;
// }
//
// return Positioned(
// top: _getTopPosition(index),
// left: _getLeftPosition(index),
// child: GestureDetector(
// onTap: () {
// // _showTextFieldDialog(context, task.matricule);
// },
// child: Transform.rotate(
// angle: _getAngle(index) * 0.0174533,
// child: Column(
// children: [
// Icon(
// appleIcon,
// color: appleColor,
// size: 30,
// ),
// _buildFloatingCar(task.status, task.matricule),
// ],
// ),
// ),
// ),
// );
// }).toList(),
