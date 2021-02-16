import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_back_top.dart';
import 'package:college_transport_booking_app/widgets/button_text.dart';
import 'package:college_transport_booking_app/widgets/textfield_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterStudent extends StatefulWidget {
  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  final dbHelper = DatabaseHelper.instance;

  final contStudentID = TextEditingController();
  final contFullName = TextEditingController();
  final contEmail = TextEditingController();
  final contPhoneNumber = TextEditingController();
  final contSemester = TextEditingController();
  final contClass = TextEditingController();
  final contPassword = TextEditingController();

  @override
  void dispose() {
    contStudentID.dispose();
    contFullName.dispose();
    contEmail.dispose();
    contPhoneNumber.dispose();
    contSemester.dispose();
    contClass.dispose();
    contPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).buttonColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'PoppinsBold',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: ButtonBackTop(
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        leadingWidth: 100,
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextfieldBox(
                      controller: contStudentID,
                      label: 'Student ID',
                    ),
                    TextfieldBox(
                      controller: contFullName,
                      label: 'Full Name',
                    ),
                    TextfieldBox(
                      controller: contEmail,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextfieldBox(
                      controller: contPhoneNumber,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                    ),
                    TextfieldBox(
                      controller: contSemester,
                      label: 'Semester',
                      keyboardType: TextInputType.number,
                    ),
                    TextfieldBox(
                      controller: contClass,
                      label: 'Class',
                    ),
                    TextfieldBox(
                      controller: contPassword,
                      label: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonText(
                        text: 'Submit',
                        buttonColor: Theme.of(context).primaryColor,
                        onTap: () async {
                          if (contStudentID.text == '' ||
                              contFullName.text == '' ||
                              contEmail.text == '' ||
                              contClass.text == '' ||
                              contPassword.text == '' ||
                              contPhoneNumber.text == '' ||
                              contSemester.text == '') {
                            Fluttertoast.showToast(
                                msg: 'Please fill in all details');
                            print(
                                'SHANGRI-LA ERROR: some textfield not filled!');
                            return false;
                          }
                          if (contStudentID.text.contains(" ") ||
                              contEmail.text.contains(" ")) {
                            Fluttertoast.showToast(
                                msg:
                                    'There can be whitespace for student id or email!');
                            print(
                                'SHANGRI-LA ERROR: id or email has whitespace!');
                            return false;
                          }
                          if (!contEmail.text.contains('@')) {
                            Fluttertoast.showToast(
                                msg: 'Please enter correct email format');
                            print('SHANGRI-LA ERROR: email format incorrect');
                            return false;
                          }
                          if (contPassword.text.length < 8) {
                            Fluttertoast.showToast(
                                msg:
                                    'Password has to be more than 8 characters');
                            print(
                                'SHANGRI-LA ERROR: Password has to be more than 8');
                            return false;
                          }
                          print('Registering student...');
                          Map<String, dynamic> studentRow = {
                            DatabaseHelper.user_type: 'student',
                            DatabaseHelper.student_id: contStudentID.text,
                            DatabaseHelper.user_full_name: contFullName.text,
                            DatabaseHelper.user_email: contEmail.text,
                            DatabaseHelper.student_class: contClass.text,
                            DatabaseHelper.password: contPassword.text,
                            DatabaseHelper.user_phone_number:
                                contPhoneNumber.text,
                            DatabaseHelper.student_semester: contSemester.text,
                          };
                          print('Entered data:');
                          studentRow
                              .forEach((key, value) => print('$key: $value'));
                          final id = await dbHelper.insert(
                              DatabaseHelper.tb_user, studentRow);
                          print('Inserted row id to tb_student $id successful');
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg: 'Student Registration Successful');
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
