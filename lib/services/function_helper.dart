import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:flutter/cupertino.dart';

class FunctionHelper {
  final dbHelper = DatabaseHelper.instance;
  FunctionHelper._privateConstructor();
  static final FunctionHelper instance = FunctionHelper._privateConstructor();

  Future<void> logOut(User user, BuildContext context) async {
    print('Signing out ${user.user_email}');
    await dbHelper.updateSession(0, user.user_email);
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/loginPage',
      ModalRoute.withName('/'),
    );
  }
}
