import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:college_transport_booking_app/widgets/title_and_text.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({
    Key key,
    @required this.submission,
    @required this.user,
  }) : super(key: key);
  final Submission submission;
  final User user;
  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialogSubInfo();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
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
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                            size: 18,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 7)),
                        TextSpan(
                          text: widget.submission.submission_location,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.watch_later,
                            color: Theme.of(context).primaryColor,
                            size: 18,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 7)),
                        TextSpan(
                          text: widget
                              .submission.date_time_departure_to_location
                              .toString(),
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

  showDialogSubInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Submission submission = widget.submission;
        return DialogCustom(
          dialogTitle: 'Trip Submission Info',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            TitleAndText(
              title: 'Status',
              text: submission.submission_status.toUpperCase(),
            ),
            submission.submission_student_id != null &&
                    widget.user.user_type != 'student'
                ? FutureBuilder<User>(
                    future:
                        dbHelper.getUserById(submission.submission_student_id),
                    builder: (context, snapshot) {
                      User student = snapshot.data;
                      return snapshot.hasData
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleAndText(
                                  title: 'Student',
                                  text: student.user_full_name,
                                ),
                                TitleAndText(
                                  title: 'Student Phone Number',
                                  text: student.user_phone_number,
                                ),
                                TitleAndText(
                                  title: 'Student Email',
                                  text: student.user_email,
                                ),
                              ],
                            )
                          : CupertinoActivityIndicator();
                    })
                : SizedBox(),
            submission.submission_driver_id != null &&
                    widget.user.user_type != 'driver'
                ? FutureBuilder<User>(
                    future:
                        dbHelper.getUserById(submission.submission_driver_id),
                    builder: (context, snapshot) {
                      User driver = snapshot.data;
                      return snapshot.hasData
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleAndText(
                                  title: 'Driver',
                                  text: driver.user_full_name,
                                ),
                                TitleAndText(
                                  title: 'Student Phone Number',
                                  text: driver.user_phone_number,
                                ),
                                TitleAndText(
                                  title: 'Student Email',
                                  text: driver.user_email,
                                ),
                              ],
                            )
                          : CupertinoActivityIndicator();
                    })
                : SizedBox(),
            TitleAndText(
              title: 'Location',
              text: submission.submission_location,
            ),
            TitleAndText(
              title: 'Companion',
              text: submission.companion_name,
            ),
            TitleAndText(
              title: 'Companion Email',
              text: submission.companion_email,
            ),
            TitleAndText(
              title: 'Companion Phone Number',
              text: submission.companion_phone_no,
            ),
            TitleAndText(
              title: 'Departure From College to Location',
              text: submission.date_time_departure_to_location,
            ),
            TitleAndText(
              title: 'Departure From Location to College',
              text: submission.date_time_departure_from_location,
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //TODO remove certain button depending on situation and user type
            ButtonDialog(
              label: 'Assign Driver',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                // showDialogManageSub();
              },
            ),
          ],
        );
      },
    );
  }

  //TODO finish shit below

  // showDialogManageSub() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       String assignedDriver = 'Choose Driver';
  //       return DialogCustom(
  //         dialogTitle: 'Assign Driver',
  //         contentWidget: [
  //           SizedBox(width: MediaQuery.of(context).size.width),
  //           FutureBuilder<List<User>>(
  //               future: dbHelper.getUserListByType('driver'),
  //               builder: (context, snapshot) {
  //                 List<User> driverList = snapshot.data;
  //                 print('$driverList');
  //                 return DropdownButtonHideUnderline(
  //                   child: DropdownButton<String>(
  //                     value: assignedDriver,
  //                     icon: Icon(Icons.arrow_downward),
  //                     iconSize: 24,
  //                     elevation: 16,
  //                     style: TextStyle(color: Colors.deepPurple),
  //                     underline: Container(
  //                       height: 2,
  //                       color: Colors.deepPurpleAccent,
  //                     ),
  //                     onChanged: (String newValue) {
  //                       setState(() {
  //                         assignedDriver = newValue;
  //                       });
  //                       print('assignedDriver: $assignedDriver');
  //                       print('newValue: $newValue');
  //                     },
  //                     items: driverList
  //                         .map<DropdownMenuItem<String>>((User driver) {
  //                       return DropdownMenuItem<String>(
  //                         value: driver.user_id.toString(),
  //                         child: Text(driver.user_full_name),
  //                       );
  //                     }).toList(),
  //                   ),
  //                 );
  //               }),
  //         ],
  //         footerWidget: [
  //           ButtonDialog(
  //             label: 'Submit',
  //             fontColor: Theme.of(context).buttonColor,
  //             onPressed: () {
  //               print('assignedDriver: $assignedDriver');
  //             },
  //           ),
  //           ButtonDialog(
  //             label: 'Dismiss',
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // showDialogManageSub() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //

  //       // List<User> driverList = await dbHelper.getUserListByType('driver');
  //       String statusValue = 'Pending';
  //       List<String> list = [
  //         'Pending',
  //         'Confirmed',
  //         'Cancelled',
  //       ];

  //       return DialogCustom(
  //         dialogTitle: 'Manage Submission Info',
  //         contentWidget: [
  //           SizedBox(width: MediaQuery.of(context).size.width),
  //           DropdownButtonHideUnderline(
  //             child: DropdownButton<String>(
  //               value: statusValue,
  //               icon: Icon(Icons.arrow_downward),
  //               iconSize: 24,
  //               elevation: 16,
  //               style: TextStyle(color: Colors.deepPurple),
  //               underline: Container(
  //                 height: 2,
  //                 color: Colors.deepPurpleAccent,
  //               ),
  //               onChanged: (String newValue) {
  //                 setState(() {
  //                   statusValue = newValue;
  //                 });
  //               },
  //               items: list.map<DropdownMenuItem<String>>((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value),
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //           statusValue == 'Confirmed' ? Text('Confirmed') : SizedBox(),
  //         ],
  //         footerWidget: [
  //           ButtonDialog(
  //             label: 'Dismiss',
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
