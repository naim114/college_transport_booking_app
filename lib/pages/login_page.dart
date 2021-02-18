import 'package:college_transport_booking_app/pages/register_student.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/session_wrapper.dart';
import 'package:college_transport_booking_app/widgets/app_title.dart';
import 'package:college_transport_booking_app/widgets/button_text.dart';
import 'package:college_transport_booking_app/widgets/textfield_title.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dbHelper = DatabaseHelper.instance;
  final contEmail = TextEditingController();
  final contPassword = TextEditingController();

  @override
  void dispose() {
    contEmail.dispose();
    contPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.ac_unit,
      //         color: Colors.transparent,
      //       ),
      //       onPressed: () {
      //         dbHelper.printAllData();
      //       },
      //     )
      //   ],
      // ),
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
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: AppTitle(),
                    ),
                    TextfieldTitle(
                      title: 'Email',
                      titleColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      controller: contEmail,
                    ),
                    TextfieldTitle(
                      title: 'Password',
                      titleColor: Colors.white,
                      isPassword: true,
                      controller: contPassword,
                    ),
                    SizedBox(height: 20),
                    ButtonText(
                      text: 'Login',
                      buttonColor: Theme.of(context).buttonColor,
                      onTap: () async {
                        if (contEmail.text == '' || contPassword.text == '') {
                          Fluttertoast.showToast(
                            msg: 'Please fill in all field',
                          );

                          return false;
                        }
                        await dbHelper
                            .getLogin(contEmail.text, contPassword.text)
                            .catchError((Object error) {
                          Fluttertoast.showToast(
                              msg: 'Login failed. Email or Password wrong.');
                          print('SHANGRI-LA ERROR: $error');
                          // ignore: return_of_invalid_type_from_catch_error
                          return false;
                        }).then(
                          (value) async {
                            await dbHelper.updateSession(1, contEmail.text);
                            print('Logging in to $value');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SessionWrapper(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: height * .01),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterStudent(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _query() async {
  //   List<String> list = [
  //     'tb_user',
  //     'tb_vehicle',
  //     'tb_submission',
  //   ];
  //   list.forEach((tableName) async {
  //     final allRows = await dbHelper.queryAllRows(tableName);
  //     print('query all rows for $tableName:');
  //     allRows.forEach((row) {
  //       print('=======================$tableName=========================');
  //       print(row);
  //       print('=======================$tableName=========================');
  //       Fluttertoast.showToast(msg: '$tableName ==> $row');
  //     });
  //   });

  //   // String tableName = 'tb_driver';
  //   // final allRows = await dbHelper.queryAllRows(tableName);
  //   // print('query all rows for $tableName:');
  //   // allRows.forEach((row) => print(row));
  // }
}
