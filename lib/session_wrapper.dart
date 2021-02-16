import 'package:college_transport_booking_app/frame.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/pages/login_page.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionWrapper extends StatefulWidget {
  @override
  _SessionWrapperState createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: dbHelper.checkSession(),
      builder: (context, snapshot) {
        User user = snapshot.data;
        print('current user: ${snapshot.data}');
        return snapshot.hasData
            ? FutureProvider<User>.value(
                value: dbHelper.checkSession(),
                initialData: User(
                  user_id: 0,
                  user_full_name: '...loading',
                  password: '...loading',
                  user_type: '...loading',
                  user_phone_number: '...loading',
                  user_email: '...loading',
                  user_delete_flag: 0,
                  head_driver: 0,
                  student_semester: 0,
                  student_id: '...loading',
                  student_class: '...loading',
                  user_session: 1,
                ),
                child: Frame(),
              )
            : LoginPage();
      },
    );
  }
}
