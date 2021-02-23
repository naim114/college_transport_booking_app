import 'package:college_transport_booking_app/pages/login_page.dart';
import 'package:college_transport_booking_app/pages/register_student.dart';
import 'package:college_transport_booking_app/session_wrapper.dart';
import 'package:flutter/material.dart';

// TODO try fix the ConcurrentModificationError, problem occurs when add list before build complete, look up build finish callback (?), try not to setstate inside inistate
// at homepage, wrap calendar with future builder and return the subList based on condition
// TODO apparently this still not correct, error when that date have more than 3 trip
// TODO when assigning driver & vehicle if the driver & vehicle is unavailable on that date return false
// dah buat maybe salah dekat year, month, date condition

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Transportation Booking App',
      theme: ThemeData(
        fontFamily: 'GothicA1',
        primaryColor: Color.fromRGBO(125, 86, 232, 1), //dark purple
        // accentColor: Color.fromRGBO(86, 154, 232, 1), //blue
        accentColor: Colors.orangeAccent,
        // highlightColor: Color.fromRGBO(245, 35, 87, 1), //#f52357 //red-pink
        // secondaryHeaderColor: Colors.indigo[900],
        buttonColor: Color.fromRGBO(198, 86, 232, 1), //purple

        // textSelectionTheme: TextSelectionThemeData(
        //   cursorColor: Colors.indigo[900],
        // ),
        // cardColor: Colors.indigo[900],
        // appBarTheme: AppBarTheme(
        //   backgroundColor: Color.fromRGBO(245, 35, 87, 1),
        //   color: Color.fromRGBO(245, 35, 87, 1),
        //   centerTitle: true,
        //   titleTextStyle: TextStyle(color: Colors.white),
        //   // iconTheme: IconThemeData(
        //   //   color: Colors.white,
        //   // ),
        // ),
      ),
      // home: LandingPage(),
      routes: {
        '/': (context) => SessionWrapper(),
        '/registerStudent': (context) => RegisterStudent(),
        '/loginPage': (context) => LoginPage(),
      },
    );
  }
}
