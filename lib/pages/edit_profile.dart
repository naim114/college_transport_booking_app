import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_rounded_corner.dart';
import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController contFullName;
  TextEditingController contPhoneNumber;
  TextEditingController contStudentID;
  TextEditingController contClass;
  TextEditingController contSemester;
  final dbHelper = DatabaseHelper.instance;

  void initState() {
    super.initState();
    contFullName = TextEditingController(
        text: widget.user.user_full_name ?? 'No Full Name');
    contPhoneNumber = TextEditingController(
        text: widget.user.user_phone_number ?? 'Phone Number');
    contStudentID =
        TextEditingController(text: widget.user.student_id ?? 'No Student ID');
    contClass =
        TextEditingController(text: widget.user.student_class ?? 'No Class');
    contSemester = TextEditingController(
      text: widget.user.student_semester.toString() ?? 'No Semester',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Your Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        children: [
          Text(
            'Note: If there is no changes after edit submission, please log out and sign in back or restart the app.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
              ),
              initialValue: widget.user.user_email ?? 'No Email',
              enabled: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Full Name",
              ),
              // initialValue: widget.user.user_full_name ?? 'No Full Name',
              controller: contFullName,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Phone Number",
              ),
              // initialValue: widget.user.user_phone_number ?? 'Phone Number',
              keyboardType: TextInputType.phone,
              controller: contPhoneNumber,
            ),
          ),
          widget.user.user_type == 'student'
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Student ID",
                    ),
                    // initialValue: widget.user.student_id ?? 'No Student ID',
                    controller: contStudentID,
                  ),
                )
              : SizedBox.shrink(),
          widget.user.user_type == 'student'
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Class",
                    ),
                    // initialValue: widget.user.student_class ?? 'No Class',
                    controller: contClass,
                  ),
                )
              : SizedBox.shrink(),
          widget.user.user_type == 'student'
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Semester",
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    // initialValue: widget.user.student_semester.toString() ??
                    //     'No Semester',
                    controller: contSemester,
                  ),
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: ButtonRoundedCorner(
              label: 'Submit',
              buttonColor: Theme.of(context).buttonColor,
              borderColor: Theme.of(context).buttonColor,
              onPressed: () async {
                if (contFullName.text == '' ||
                    contPhoneNumber.text == '' ||
                    contStudentID.text == '' ||
                    contClass.text == '' ||
                    contSemester.text == '') {
                  Fluttertoast.showToast(msg: 'Please fill in all details');
                  print('SHANGRI-LA ERROR: some textfield not filled!');
                  return false;
                }
                if (contStudentID.text.contains(" ")) {
                  Fluttertoast.showToast(
                      msg: 'There can be whitespace for student id!');
                  print('SHANGRI-LA ERROR: id or email has whitespace!');
                  return false;
                }

                Map<String, dynamic> dataRow = {
                  DatabaseHelper.user_full_name: contFullName.text,
                  DatabaseHelper.user_phone_number: contPhoneNumber.text,
                  DatabaseHelper.student_id: contStudentID.text,
                  DatabaseHelper.student_class: contClass.text,
                  DatabaseHelper.student_semester: contSemester.text,
                };

                print('/////////data row/////////');
                dataRow.forEach((key, value) {
                  print('$key ==> $value');
                });
                print('/////////data row/////////');

                dataRow.forEach((key, value) {
                  print('updating $key with $value');
                  final id = dbHelper.updateUserProfile(
                    key,
                    value,
                    widget.user.user_email,
                  );
                  print('Update data $id successful');
                });

                Fluttertoast.showToast(
                    msg: 'User profile sucessfully updated!');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  ModalRoute.withName('/'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
