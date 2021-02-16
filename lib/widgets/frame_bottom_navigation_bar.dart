import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrameBottomNavigationBar extends StatefulWidget {
  final Function onTabTapped;
  final PageController pageController;

  const FrameBottomNavigationBar({
    Key key,
    @required this.onTabTapped,
    @required this.pageController,
  }) : super(key: key);
  @override
  _FrameBottomNavigationBarState createState() =>
      _FrameBottomNavigationBarState();
}

class _FrameBottomNavigationBarState extends State<FrameBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    widget.pageController.addListener(() {
      if (widget.pageController.page.round() != _currentIndex) {
        setState(() {
          _currentIndex = widget.pageController.page.round();
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_transportation_rounded),
          label: 'Booking List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      onTap: (index) {
        widget.onTabTapped(index);
      },
    );
  }
}
