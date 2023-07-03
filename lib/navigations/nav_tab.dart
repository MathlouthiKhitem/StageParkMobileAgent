import 'package:flutter/material.dart';
import 'package:parkmobile/parking/Home.dart';

import 'package:parkmobile/parking/SleekCircularSlider.dart';
import 'package:parkmobile/parking/info.dart';

import 'nav_bottom.dart';
class NavigationTab extends StatefulWidget {
  @override
  _NavigationTabState createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(9.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  color: Colors.deepPurpleAccent,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: "Infomation",
                    icon: Icon(Icons.info_outlined),
                  ),
                  Tab(
                    text: "Home",
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: "Time",
                    icon: Icon(Icons.timelapse_outlined),
                  ),

                ],
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
              ),
            ),
            // tab bar view here
            Expanded(
              child: IndexedStack(
                index: _tabController.index,
                children: [
                  const Info(),
                   NavigationBottom(),
                  SleekCircularSliderExample(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

