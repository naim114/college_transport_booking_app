import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/pages/booking_list.dart';
import 'package:college_transport_booking_app/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/pages/homepage.dart';
import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:provider/provider.dart';

class Frame extends StatefulWidget {
  const Frame({
    Key key,
  }) : super(key: key);

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return user == null
        ? CupertinoActivityIndicator()
        : Scaffold(
            body: PageView(
              controller: pageController,
              children: [
                Homepage(),
                BookingList(),
                Settings(),
              ],
              // pageSnapping: true,
            ),
            // bottomNavigationBar: FrameBottomNavigationBar(
            //   pageController: pageController,
            //   onTabTapped: (index) {
            //     pageController.animateToPage(index,
            //         duration: Duration(milliseconds: 333), curve: Curves.easeIn);
            //   },
            // ),
            bottomNavigationBar: FlipBoxBar(
              items: [
                FlipBarItem(
                  icon: Icon(Icons.home),
                  text: Text(
                    "Home",
                    style: TextStyle(fontSize: 10),
                  ),
                  frontColor: Colors.purple,
                  backColor: Colors.purpleAccent,
                ),
                FlipBarItem(
                  icon: Icon(Icons.list_alt_rounded),
                  text: Text(
                    "Booking List",
                    style: TextStyle(fontSize: 10),
                  ),
                  frontColor: Colors.orange,
                  backColor: Colors.orangeAccent,
                ),
                FlipBarItem(
                  icon: Icon(Icons.settings),
                  text: Text(
                    "Settings",
                    style: TextStyle(fontSize: 10),
                  ),
                  frontColor: Colors.pink,
                  backColor: Colors.pinkAccent,
                ),
              ],
              onIndexChanged: (newIndex) {
                setState(() {
                  selectedIndex = newIndex;
                });
                pageController.animateToPage(
                  newIndex,
                  duration: Duration(milliseconds: 333),
                  curve: Curves.easeIn,
                );
              },
              selectedIndex: selectedIndex,
            ),
          );
  }
}
