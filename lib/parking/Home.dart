import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AnimatedProgressBar.dart';
import 'SleekCircularSlider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  TimeOfDay? selectedTime;
  double progress = 0.0;


  @override
  void initState() {
    super.initState();
    _updateProgress();
  }


  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (selectedTime != null) {
      setState(() {
        startTime = selectedTime;
        _updateProgress();
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: endTime,
    );

    if (selectedTime != null) {
      setState(() {
        endTime = selectedTime;
        _updateProgress();
      });
    }
  }

  double calculateProgress() {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    final totalMinutes = 24 * 60; // 24 hours * 60 minutes
    return (endMinutes - startMinutes) / totalMinutes;
  }


  void _updateProgress() {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    final totalMinutes = 24 * 60; // 24 hours * 60 minutes
    final newProgress = (endMinutes - startMinutes) / totalMinutes;
    setState(() {
      progress = newProgress;
    });
  }



  Duration calculateDuration() {
    final now = DateTime.now();
    final startDate = DateTime(startTime.hour);
    var endDate = DateTime( endTime.hour);



    if (endDate.isBefore(startDate)) {
      // Set endDate to the next day
      endDate = endDate.add(Duration(days: 1));
    }

    return endDate.difference(startDate);

  }
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingControllervoiture = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNodevoitre = FocusNode();
  void _showLocationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Dismiss the modal when tapping outside the content
            Navigator.pop(context);
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      'lib/images/undraw_navigation_re_wxx4 1.png',
                      width: 170,
                      height: 160,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Center(
                    child: Text(
                      "Add location",
                      style: TextStyle(
                        color: Color(0xFF4448AE),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Image.asset(
                    'lib/images/icône-de-violet-location-119002249.webp',
                    width: 70,
                    height: 70,
                  ),
                  title: Text('Location entre manuellement'),
                  onTap: () {
                    Navigator.pop(context);
                    _focusNode.requestFocus(); // Set focus to the text field
                  },
                ),
                SizedBox(height: 29),
                ListTile(
                  leading: Image.asset(
                    'lib/images/download.png',
                    width: 70,
                    height: 70,
                  ),
                  title: Text('Recherché par map'),
                  onTap: () {
                    // Handle location 3 selection
                    //  Navigator.pop(context); // Close the modal
                  },
                ),
                SizedBox(height: 29),
                ListTile(
                  leading: Image.asset(
                    'lib/images/download (1).png',
                    width: 70,
                    height: 70,
                  ),
                  title: Text('Recherché par map'),
                  onTap: () {
                    // Handle location 3 selection
                    //  Navigator.pop(context); // Close the modal
                  },
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Dismiss the modal when tapping outside the content
            Navigator.pop(context);
          },
          child: Container(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  child: Center(
                    child: SvgPicture.asset(
                      'lib/images/undraw_order_ride_re_372k.svg',
                      width: 100,
                      height: 90,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  child: const Center(
                    child: Text(
                      "Add Car!",
                      style: TextStyle(
                        color: Color(0xFF4448AE),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: const Center(
                    child: Text(
                      "Ajouter le matricule voiture",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                ListTile(
                  leading: Image.asset(
                    'lib/images/symbole-de-voiture-icone-png-violet.png',
                    width: 70,
                    height: 70,
                  ),
                  title: Text('Ajouter Matricule voiture '),
                  onTap: () {
                    Navigator.pop(context);
                    _focusNodevoitre.requestFocus(); // Set focus to the text field
                  },
                ),
                SizedBox(height: 29),
                ListTile(
                  leading: Image.asset(
                    'lib/images/images (1).png',
                    width: 70,
                    height: 70,
                  ),
                  title: Text('scanner matricule voiture'),
                  onTap: () {
                    // Handle location 3 selection
                    //  Navigator.pop(context); // Close the modal
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override

  Widget build(BuildContext context) {
    Duration duration = calculateDuration();
    double progress = this.progress;
    print('Duration: $progress');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Align(
              alignment: Alignment.center,
              child: Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: const TextStyle(
                        fontSize: 25,
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),

                      prefixIcon: IconButton(
                        icon: const Icon(Icons.location_on, color: Color(0xFF4448AE)),
                        onPressed: () => _showLocationModal(context),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 50.0),
                      border: InputBorder.none,
                    ),
                  )
              ),
            ),


            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    _showModal(context);
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Center(
                          child: Image.asset(
                            'lib/images/auto 1.png',
                            width: 170,
                            height: 160,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textEditingControllervoiture,
                            focusNode: _focusNodevoitre,
                            decoration: const InputDecoration(
                              labelText: 'Matricule',
                              contentPadding: EdgeInsets.symmetric(vertical: 30.0),
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF212121),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            const Text('Start Time:', style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.bold,
                        ),),
                            GestureDetector(
                              onTap: () => _selectStartTime(context),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'lib/images/timeicone.png',
                                    width: 200,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    startTime.format(context),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            const Text('End Time:',  style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                            ),),
                            GestureDetector(
                              onTap: () => _selectEndTime(context),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'lib/images/timeicone.png',
                                    width: 200,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    endTime.format(context),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],

                        ),

                      ),

                    ],

                  ),
                ),

              ),

            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 30, 10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF999CF0),
                  ),
                  child: const Text("PRIX"),
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 60, 0),
              child: const SizedBox(
                width: 200,
                height: 50,
                child: Text(
                  "Total: 8.00 dt",
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),
                ),
              ),
            ),


            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: SizedBox(
                width: 348,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF999CF0),
                  ),
                  child: const Text("NEXT"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/homeTab");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SleekCircularSliderExample(selectedTime: selectedTime),
                    //   ),
                    // );
                    // Handle button press
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(right: 30.0, bottom: 170.0),
        child: SizedBox(
          width: 20,
          child: VerticalProgressBar(
            height: 200.0,
            value: progress, // Updated progress value
            duration: duration,
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }











}




