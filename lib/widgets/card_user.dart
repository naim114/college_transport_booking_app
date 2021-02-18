import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:college_transport_booking_app/widgets/title_and_text.dart';

class CardUser extends StatefulWidget {
  const CardUser({
    Key key,
    @required this.user,
    @required this.currentUser,
  }) : super(key: key);

  final User user;
  final User currentUser;

  @override
  _CardUserState createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialogUserInfo();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          color: Theme.of(context).buttonColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: Container(
              width: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            widget.user.head_driver == 1
                                ? Icons.star
                                : Icons.person,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 15)),
                        TextSpan(
                          text: widget.user.user_email,
                          style: TextStyle(
                            color: Colors.white,
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
      ),
    );
  }

  showDialogUserInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'User Info',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            TitleAndText(
              title: 'Full Name',
              text: widget.user.user_full_name,
            ),
            TitleAndText(
              title: 'Email',
              text: widget.user.user_email,
            ),
            TitleAndText(
              title: 'Phone Number',
              text: widget.user.user_phone_number,
            ),
            widget.user.user_type == 'driver'
                ? TitleAndText(
                    title: 'Head Driver',
                    text: widget.user.head_driver == 1 ? 'Yes' : 'No',
                  )
                : SizedBox.shrink(),
            widget.user.user_type == 'student'
                ? TitleAndText(
                    title: 'Student ID',
                    text: widget.user.student_id,
                  )
                : SizedBox.shrink(),
            widget.user.user_type == 'student'
                ? TitleAndText(
                    title: 'Class',
                    text: widget.user.student_class,
                  )
                : SizedBox.shrink(),
            widget.user.user_type == 'student'
                ? TitleAndText(
                    title: 'Semester',
                    text: widget.user.student_semester.toString(),
                  )
                : SizedBox.shrink(),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            widget.user.user_type == 'driver' &&
                    widget.user.head_driver == 0 &&
                    widget.currentUser.user_type == 'admin'
                ? ButtonDialog(
                    label: 'Promote to Head Driver',
                    fontColor: Theme.of(context).buttonColor,
                    onPressed: () {
                      showDialogMakeHeadDriver();
                    },
                  )
                : SizedBox.shrink(),
            widget.user.user_type == 'driver' &&
                    widget.user.head_driver == 1 &&
                    widget.currentUser.user_type == 'admin'
                ? ButtonDialog(
                    label: 'Demote Head Driver',
                    fontColor: Theme.of(context).buttonColor,
                    onPressed: () {
                      showDialogDemote();
                    },
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }

  showDialogMakeHeadDriver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Make This User A Head Driver',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
                'Are you sure you wanted to make this driver a head driver? Head driver has access to for features that not available for other drivers such as viewing all drivers table, editing vehicle info and assigning driver to pending trip submission.'),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Confirm',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                Map<String, dynamic> dataMap = {DatabaseHelper.head_driver: 1};
                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_user,
                  DatabaseHelper.user_id,
                  widget.user.user_id,
                  dataMap,
                );

                Fluttertoast.showToast(
                    msg:
                        '${widget.user.user_email} has been promoted to Head Driver!');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  showDialogDemote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Demote from Being Head Driver',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
                'Are you sure you wanted to make this driver a not a head driver anymore?'),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Confirm',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                Map<String, dynamic> dataMap = {DatabaseHelper.head_driver: 0};
                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_user,
                  DatabaseHelper.user_id,
                  widget.user.user_id,
                  dataMap,
                );

                Fluttertoast.showToast(
                    msg:
                        '${widget.user.user_email} has been demoted from being Head Driver :(');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
