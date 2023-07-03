// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';
//
// class CircularSliderWidget extends StatefulWidget {
//   final TimeOfDay selectedTime;
//   final Function(TimeOfDay) onTimeChanged;
//
//   CircularSliderWidget({
//     required this.selectedTime,
//     required this.onTimeChanged,
//   });
//
//   @override
//   _CircularSliderWidgetState createState() => _CircularSliderWidgetState();
// }
//
// class _CircularSliderWidgetState extends State<CircularSliderWidget> {
//   double _sliderValue = 0.0;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeSliderValue();
//     _startTimer();
//   }
//
//   void _initializeSliderValue() {
//     // Calculate the total number of seconds in the selected time
//     int totalSeconds = widget.selectedTime.hour * 3600 +
//         widget.selectedTime.minute * 60;
//
//     // Set the initial slider value based on the total seconds
//     setState(() {
//       _sliderValue = totalSeconds.toDouble();
//     });
//   }
//
//   void _startTimer() {
//     _timer = Timer.periodic(Duration(minutes: 1), (_) {
//       // Convert the slider value back to hours and minutes
//       int totalSeconds = _sliderValue.toInt();
//       if (totalSeconds <= 0) {
//         _timer.cancel();
//       } else {
//         totalSeconds -= 60;
//         int hours = totalSeconds ~/ 3600;
//         totalSeconds %= 3600;
//         int minutes = totalSeconds ~/ 60;
//
//         // Call the onTimeChanged callback with the updated time
//         widget.onTimeChanged(TimeOfDay(hour: hours, minute: minutes));
//
//         setState(() {
//           _sliderValue = totalSeconds.toDouble();
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   void _onSliderChanged(double value) {
//     setState(() {
//       _sliderValue = value;
//     });
//
//     // Convert the slider value back to hours and minutes
//     int totalSeconds = _sliderValue.toInt();
//     int hours = totalSeconds ~/ 3600;
//     totalSeconds %= 3600;
//     int minutes = totalSeconds ~/ 60;
//
//     // Call the onTimeChanged callback with the updated time
//     widget.onTimeChanged(TimeOfDay(hour: hours, minute: minutes));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Time',
//           style: TextStyle(fontSize: 18),
//         ),
//         Text(
//           widget.selectedTime.format(context),
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SleekCircularSlider(
//           appearance: CircularSliderAppearance(
//             customColors: CustomSliderColors(
//               progressBarColors: [Colors.blue, Colors.lightBlueAccent],
//               trackColor: Colors.grey,
//             ),
//             infoProperties: InfoProperties(
//               modifier: (double value) {
//                 // Convert the slider value to hours, minutes, and seconds
//                 int totalSeconds = value.toInt();
//                 int hours = totalSeconds ~/ 3600;
//                 totalSeconds %= 3600;
//                 int minutes = totalSeconds ~/ 60;
//                 int seconds = totalSeconds % 60;
//
//                 // Display the time in the center of the slider
//                 return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
//               },
//               mainLabelStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           min: 0,
//           max: 86400, // Total number of seconds in a day
//           initialValue: _sliderValue,
//           onChange: _onSliderChanged,
//         ),
//       ],
//     );
//   }
// }
//
// class SleekCircularSliderExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);
//
//     void handleTimeChanged(TimeOfDay newTime) {
//       selectedTime = newTime;
//       // Handle the updated time as needed
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sleek Circular Slider Example'),
//       ),
//       body: Center(
//         child: CircularSliderWidget(
//           selectedTime: selectedTime,
//           onTimeChanged: handleTimeChanged,
//         ),
//       ),
//     );
//   }
// }
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularSliderWidget extends StatelessWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeChanged;

  CircularSliderWidget({
    required this.selectedTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          selectedTime.format(context),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SleekCircularSlider(
          appearance: CircularSliderAppearance(
            customColors: CustomSliderColors(
              progressBarColors: [Colors.deepPurpleAccent, Colors.lightBlueAccent],
              trackColor: Colors.grey,
            ),
            infoProperties: InfoProperties(
              modifier: (double value) {
                // Convert the slider value to hours, minutes, and seconds
                int totalSeconds = value.toInt();
                int hours = totalSeconds ~/ 3600;
                totalSeconds %= 3600;
                int minutes = totalSeconds ~/ 60;
                int seconds = totalSeconds % 60;

                // Display the time in the center of the slider
                return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
              },
              mainLabelStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          min: 0,
          max: selectedTime.hour * 3600 + selectedTime.minute * 60,
          initialValue: selectedTime.hour * 3600 + selectedTime.minute * 60,
          onChange: (double value) {
            // Convert the slider value back to hours and minutes
            int totalSeconds = value.toInt();
            int hours = totalSeconds ~/ 3600;
            totalSeconds %= 3600;
            int minutes = totalSeconds ~/ 60;

            // Call the onTimeChanged callback with the updated time
            onTimeChanged(TimeOfDay(hour: hours, minute: minutes));
          },
        ),
      ],
    );
  }
}

class SleekCircularSliderExample extends StatefulWidget {
  @override
  _SleekCircularSliderExampleState createState() => _SleekCircularSliderExampleState();
}

class _SleekCircularSliderExampleState extends State<SleekCircularSliderExample> {
  late Timer _timer;
  late TimeOfDay selectedTime;

  get crossAxisAlignment => null;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay(hour: 10, minute: 0);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Decrement the selected time by 1 second
        if (selectedTime.minute > 0 || selectedTime.hour > 0) {
          if (selectedTime.minute == 0) {
            selectedTime = TimeOfDay(hour: selectedTime.hour - 1, minute: 59);
          } else {
            selectedTime = TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute - 1);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void handleTimeChanged(TimeOfDay newTime) {
    selectedTime = newTime;
    // Handle the updated time as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        const Padding(
        padding: EdgeInsets.all(50.0),
        child: Text(
          'Parking Time',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
          Align(
          alignment: Alignment.center,
          child: Expanded(
              child:CircularSliderWidget(
                selectedTime: selectedTime,
                onTimeChanged: handleTimeChanged,
              ),
          ),
        ),
              const Align(
                alignment: Alignment.center,
                child: Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(

                         children: [   Text(
                           'Parking Area :' ,
                           style: TextStyle(
                             fontSize: 13,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                           SizedBox(
                             width: 20,
                           ),
                           Text(
                             'Parking Lot of San Manolia',
                             style: TextStyle(fontSize: 15),
                           ),],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Row(

                            children: [   Text(
                              'Address :' ,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                '9569, Trantow Courts',
                                style: TextStyle(fontSize: 15),
                              ),],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Row(

                            children: [
                              Text(
                              'Car' ,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                ' (AF 4793 JU)',
                                style: TextStyle(fontSize: 15),
                              ),],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Row(

                            children: [   Text(
                              'Duration :' ,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                '4 hours',
                                style: TextStyle(fontSize: 15),
                              ),],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Row(

                            children: [   Text(
                              'Hours :' ,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              SizedBox(
                                width:80,
                              ),
                              Text(
                                '09.00 AM - 13.00 PM',
                                style: TextStyle(fontSize: 15),
                              ),],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 90,
              ),
              Align(
                alignment: Alignment.center,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF999CF0), // Set the background color
                      // Set the text color
                    ),
                    child: const Text("Extend Parking Time"),
                    onPressed: () {
                       Navigator.pushNamed(context, "/homeBottom");
                    },
                  ),

                  )
                ),

  ]
      ),
        )
    );

  }
}
