import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/card_vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:college_transport_booking_app/widgets/title_and_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({
    Key key,
    @required this.submission,
    @required this.user,
    this.cardColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor,
    this.elevation = 2,
  }) : super(key: key);
  final Submission submission;
  final User user;
  final Color cardColor, textColor, iconColor;
  final double elevation;
  @override
  _BookingCardState createState() => _BookingCardState();
}

String dropdownValueDriver = 'Choose Driver';
String dropdownValueVehicle = 'Choose Vehicle';

User defaultUser = User(
  user_id: 0,
  user_full_name: dropdownValueDriver,
  password: dropdownValueDriver,
  user_type: 'driver',
  user_phone_number: dropdownValueDriver,
  user_email: dropdownValueDriver,
  user_delete_flag: 0,
  head_driver: 0,
  student_semester: 0,
  student_id: dropdownValueDriver,
  student_class: dropdownValueDriver,
  user_session: 0,
);

Vehicle defaultVehicle = Vehicle(
  vehicle_id: 0,
  plat_no: dropdownValueVehicle,
  passenger_no: 0,
  vehicle_delete_flag: 0,
  vehicle_type: 'van',
);

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
          color: widget.cardColor,
          elevation: widget.elevation,
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
                      style: TextStyle(color: widget.textColor),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_on,
                            color: widget.iconColor ??
                                Theme.of(context).primaryColor,
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
                      style: TextStyle(color: widget.textColor),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.watch_later,
                            color: widget.iconColor ??
                                Theme.of(context).primaryColor,
                            size: 18,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 7)),
                        TextSpan(
                          text: DateFormat('dd-MM-yyy kk:mm')
                              .format(DateTime.parse(widget
                                  .submission.date_time_departure_to_location))
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

        List<Widget> footer = [];

        //Confirm Trip Complete
        if (submission.submission_status == 'Confirmed' &&
            widget.user.user_type == 'driver') {
          footer.add(ButtonDialog(
            label: 'Confirm Trip Completion',
            onPressed: () {
              showDialogCompleteTrip();
            },
          ));
        }

        //Cancel Trip
        if (submission.submission_status == 'Confirmed' &&
            (widget.user.user_type == 'admin' ||
                widget.user.head_driver == 1)) {
          footer.add(
            ButtonDialog(
              label: 'Cancel Trip',
              fontColor: Colors.red,
              onPressed: () {
                showDialogCancelTrip();
              },
            ),
          );
        }

        //Approve & Disapprove/Deny Trip Submission
        if (submission.submission_status == 'Pending' &&
            widget.user.user_type == 'admin' &&
            widget.submission.pending_for_head_driver == 0) {
          footer.add(
            ButtonDialog(
              label: 'Deny Trip',
              fontColor: Colors.red,
              onPressed: () {
                showDialogDisapproveTrip();
              },
            ),
          );
          footer.add(
            ButtonDialog(
              label: 'Approve Trip',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                showDialogApproveTrip();
              },
            ),
          );
        }

        //Assign Driver & Vehicle
        if (submission.submission_status == 'Pending' &&
            (widget.user.user_type == 'admin' ||
                widget.user.head_driver == 1) &&
            submission.pending_for_head_driver == 1) {
          footer.add(
            FutureBuilder<List<List<dynamic>>>(
              future: dbHelper.getAllDriversAndVehicle(),
              builder: (context, snapshot) {
                // List<User> driverList = snapshot.data;
                List<List<dynamic>> driversVehicleList = snapshot.data;

                // driversVehicleList.forEach((list) {
                //   print('${list.runtimeType} ---- $list');
                // });

                List<User> driverList = [];
                List<Vehicle> vehicleList = [];
                driversVehicleList.forEach((list) {
                  if (list is List<User>) {
                    driverList = list;
                  } else {
                    vehicleList = list;
                  }
                });

                return snapshot.hasData
                    ? ButtonDialog(
                        label: 'Assign Driver & Vehicle',
                        fontColor: Theme.of(context).buttonColor,
                        onPressed: () {
                          // print('list of driver: $driverList');
                          // print('list of vehicle: $vehicleList');

                          showDialogAssignDriverVehicle(
                            driverList,
                            vehicleList,
                          );
                        },
                      )
                    : CupertinoActivityIndicator();
              },
            ),
          );
        }

        footer.add(
          //Dismiss
          ButtonDialog(
            label: 'Dismiss',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );

        return DialogCustom(
          dialogTitle: 'Trip Submission Info',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            TitleAndText(
              title: 'Status',
              text: submission.submission_status.toUpperCase(),
            ),
            submission.submission_status == 'Cancelled'
                ? TitleAndText(
                    title: 'Reasons of Submission Denied/Trip Cancellation',
                    text: submission.reason,
                  )
                : SizedBox.shrink(),
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
                : SizedBox.shrink(),
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
                                  title: 'Driver Phone Number',
                                  text: driver.user_phone_number,
                                ),
                                TitleAndText(
                                  title: 'Driver Email',
                                  text: driver.user_email,
                                ),
                              ],
                            )
                          : CupertinoActivityIndicator();
                    })
                : SizedBox.shrink(),
            TitleAndText(
              title: 'Location',
              text: submission.submission_location,
            ),
            TitleAndText(
              title: 'Passenger Number',
              text: submission.person_num.toString(),
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
              text: DateFormat('dd-MM-yyy kk:mm')
                  .format(DateTime.parse(
                      submission.date_time_departure_to_location))
                  .toString(),
            ),
            TitleAndText(
              title: 'Departure From Location to College',
              text: DateFormat('dd-MM-yyy kk:mm')
                  .format(DateTime.parse(
                      submission.date_time_departure_from_location))
                  .toString(),
            ),
          ],
          // footerWidget: [
          //   //Approve
          //   Visibility(
          //     visible: submission.submission_status == 'Pending' &&
          //         widget.user.user_type == 'admin' &&
          //         widget.submission.pending_for_head_driver == 0,
          //     child: ButtonDialog(
          //       label: 'Approve Trip',
          //       fontColor: Theme.of(context).buttonColor,
          //       onPressed: () {
          //         showDialogApproveTrip();
          //       },
          //     ),
          //   ),

          //   //Asign Drivers & Vehicle
          //   Visibility(
          //     visible: submission.submission_status == 'Pending' &&
          //         (widget.user.user_type == 'admin' ||
          //             widget.user.head_driver == 1) &&
          //         submission.pending_for_head_driver == 1,
          //     child: FutureBuilder<List<List<dynamic>>>(
          //       future: dbHelper.getAllDriversAndVehicle(),
          //       builder: (context, snapshot) {
          //         // List<User> driverList = snapshot.data;
          //         List<List<dynamic>> driversVehicleList = snapshot.data;

          //         // driversVehicleList.forEach((list) {
          //         //   print('${list.runtimeType} ---- $list');
          //         // });

          //         List<User> driverList = [];
          //         List<Vehicle> vehicleList = [];
          //         driversVehicleList.forEach((list) {
          //           if (list is List<User>) {
          //             driverList = list;
          //           } else {
          //             vehicleList = list;
          //           }
          //         });

          //         return snapshot.hasData
          //             ? ButtonDialog(
          //                 label: 'Assign Driver & Vehicle',
          //                 fontColor: Theme.of(context).buttonColor,
          //                 onPressed: () {
          //                   // print('list of driver: $driverList');
          //                   // print('list of vehicle: $vehicleList');

          //                   showDialogAssignDriverVehicle(
          //                     driverList,
          //                     vehicleList,
          //                   ); //IF USER IS HEAD DRIVERS (ONLY HEAD DRIVER NOT EVEN ADMIN)
          //                 },
          //               )
          //             : CupertinoActivityIndicator();
          //       },
          //     ),
          //   ),

          //   //Disapprove
          //   Visibility(
          //     visible: submission.submission_status == 'Pending' &&
          //         widget.user.user_type == 'admin' &&
          //         widget.submission.pending_for_head_driver == 0,
          //     child: ButtonDialog(
          //       label: 'Deny Trip',
          //       fontColor: Colors.red,
          //       onPressed: () {
          //         showDialogDisapproveTrip();
          //       },
          //     ),
          //   ),

          //   //Cancel Trip
          //   Visibility(
          //     visible: submission.submission_status == 'Confirmed' &&
          //         (widget.user.user_type == 'admin' ||
          //             widget.user.head_driver == 1),
          //     child: ButtonDialog(
          //       label: 'Cancel Trip',
          //       fontColor: Colors.red,
          //       onPressed: () {
          //         showDialogCancelTrip();
          //       },
          //     ),
          //   ),

          //   //Dismiss
          //   // ButtonDialog(
          //   //   label: 'Dismiss',
          //   //   onPressed: () {
          //   //     Navigator.pop(context);
          //   //   },
          //   // ),

          //   // Complete Trip
          //   submission.submission_status == 'Confirmed' &&
          //           widget.user.user_type == 'driver'
          //       ? ButtonDialog(
          //           label: 'Confirm Trip Completion',
          //           onPressed: () {
          //             showDialogCompleteTrip();
          //           },
          //         )
          //       : SizedBox.shrink(),
          // ],
          footerWidget: footer,
        );
      },
    );
  }

  showDialogApproveTrip() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Approve Trip Submission',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
              'By approving this submission this trip will be confirmed to be implement on the date & time setted.',
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Approve',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                Map<String, dynamic> dataMap = {
                  DatabaseHelper.pending_for_head_driver: 1
                };

                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_submission,
                  DatabaseHelper.submission_id,
                  widget.submission.submission_id,
                  dataMap,
                );

                Fluttertoast.showToast(
                    msg:
                        'Trip submission approved! The trip submission now will be pending for head driver to assign driver and vehicle.');
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

  showDialogDisapproveTrip() {
    TextEditingController contReason = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Deny Trip Submission',
          dialogColor: Colors.red,
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
              'Please give reason for denying this trip submission to let know the user that send the submission.',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Reason for Denying Submission",
                ),
                controller: contReason,
              ),
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Deny Submission',
              fontColor: Colors.red,
              onPressed: () {
                Map<String, dynamic> dataMap = {
                  DatabaseHelper.submission_status: 'Cancelled',
                  DatabaseHelper.reason: contReason.text,
                };

                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_submission,
                  DatabaseHelper.submission_id,
                  widget.submission.submission_id,
                  dataMap,
                );

                Fluttertoast.showToast(msg: 'Trip submission disapproved :(');
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

  showDialogCancelTrip() {
    TextEditingController contReason = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Cancel Trip',
          dialogColor: Colors.red,
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
              'Please give reason for cancelling this trip submission to let know the people involved in this trip.',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Reason for Cancelling Trip",
                ),
                controller: contReason,
              ),
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Confirm Cancel',
              fontColor: Colors.red,
              onPressed: () {
                Map<String, dynamic> dataMap = {
                  DatabaseHelper.submission_status: 'Cancelled',
                  DatabaseHelper.reason: contReason.text,
                };

                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_submission,
                  DatabaseHelper.submission_id,
                  widget.submission.submission_id,
                  dataMap,
                );

                Fluttertoast.showToast(msg: 'Trip cancelled :(');
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

  //head drivers assign driver & vehicle
  showDialogAssignDriverVehicle(
    List<User> driverList,
    List<Vehicle> vehicleList,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        driverList.insert(0, defaultUser);
        vehicleList.insert(0, defaultVehicle);
        return DialogCustom(
          dialogTitle: 'Assign Drivers & Vehicle',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
              'Assign driver that will be task to handle this trip and assign vehicle for the selected driver to use.',
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter dropDownState) {
                return Container(
                  width: double.infinity,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Driver',
                      hintText: 'Driver',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.arrow_downward),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          dropdownValueDriver = newValue;
                          dropDownState(() {
                            dropdownValueDriver = newValue;
                            // print(
                            //   'DRIVER new value: $newValue ==> dropdown value: $dropdownValueDriver',
                            // );
                          });
                        },
                        items: driverList
                            .map<DropdownMenuItem<String>>((User driver) {
                          return DropdownMenuItem<String>(
                            value: driver.user_email,
                            child: Text(driver.user_email),
                          );
                        }).toList(),
                        value: dropdownValueDriver,
                      ),
                    ),
                  ),
                );
              },
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter dropDownState) {
                return Container(
                  width: double.infinity,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Vehicle',
                      hintText: 'Vehicle',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.arrow_downward),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          dropdownValueVehicle = newValue;
                          dropDownState(() {
                            dropdownValueVehicle = newValue;
                            // print(
                            //   'Vehicle new value: $newValue ==> dropdown value: $dropdownValueVehicle',
                            // );
                          });
                        },
                        items: vehicleList
                            .map<DropdownMenuItem<String>>((Vehicle vehicle) {
                          return DropdownMenuItem<String>(
                            value: vehicle.plat_no,
                            child: Text(vehicle.plat_no),
                          );
                        }).toList(),
                        value: dropdownValueVehicle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Confirm',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () async {
                if (dropdownValueVehicle == 'Choose Vehicle' ||
                    dropdownValueDriver == 'Choose Driver') {
                  Fluttertoast.showToast(msg: 'Please fill in all info');
                  return false;
                }

                User selectedDriver =
                    await dbHelper.getUserByEmail(dropdownValueDriver);

                // Vehicle selectedVehicle =
                //     await dbHelper.getVehicleByPlatNo(dropdownValueVehicle);

                Map<String, dynamic> dataMap = {
                  DatabaseHelper.submission_driver_id: selectedDriver.user_id,
                  DatabaseHelper.plat_no: dropdownValueVehicle,
                  DatabaseHelper.submission_status: 'Confirmed',
                };

                // dataMap.values.forEach((element) {
                //   print('$element ==> ${element.runtimeType}');
                // });

                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_submission,
                  DatabaseHelper.submission_id,
                  widget.submission.submission_id,
                  dataMap,
                );

                // print('selectedDriver: ${selectedDriver.user_id}');
                // print('selectedVehicle: ${selectedVehicle.vehicle_id}');

                Fluttertoast.showToast(
                  msg:
                      'Drivers $dropdownValueDriver & Vehicle $dropdownValueVehicle assigned to the trip! This trip now can be viewed at Confrimed tab on Booking List',
                );
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

  showDialogCompleteTrip() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Comfirm Trip Completion',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Text(
              'By tapping on Confirm Complete you confirm that the trip is completed and the trip is execute as it meant to.',
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonDialog(
              label: 'Confirm',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                Map<String, dynamic> dataMap = {
                  DatabaseHelper.submission_status: 'Completed'
                };

                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_submission,
                  DatabaseHelper.submission_id,
                  widget.submission.submission_id,
                  dataMap,
                );

                Fluttertoast.showToast(
                    msg:
                        'Trip completed! Hope everybody arrived safe and sound!:)');
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
