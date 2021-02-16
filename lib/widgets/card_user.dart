import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:college_transport_booking_app/widgets/title_and_text.dart';
import 'package:flutter/material.dart';

class CardUser extends StatefulWidget {
  const CardUser({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  _CardUserState createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
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
                            Icons.person,
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
                : SizedBox(),
            widget.user.user_type == 'student'
                ? TitleAndText(
                    title: 'Student ID',
                    text: widget.user.student_id,
                  )
                : SizedBox(),
            widget.user.user_type == 'student'
                ? TitleAndText(
                    title: 'Class',
                    text: widget.user.student_class,
                  )
                : SizedBox(),
            widget.user.user_type == 'student'
                ? TitleAndText(
                    title: 'Semester',
                    text: widget.user.student_semester.toString(),
                  )
                : SizedBox(),
          ],
          footerWidget: [
            //last
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
