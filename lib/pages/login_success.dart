import 'package:college_transport_booking_app/frame.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_rounded_corner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/models/model_user.dart';

class LoginSuccess extends StatefulWidget {
  final User user;

  LoginSuccess({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _LoginSuccessState createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.checkSession(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        User user = snapshot.data;
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.ac_unit,
                        color: Colors.transparent,
                      ),
                      onPressed: () {
                        List<String> list = [
                          'tb_user',
                          'tb_vehicle',
                          'tb_submission',
                        ];
                        list.forEach((tableName) async {
                          final allRows =
                              await dbHelper.queryAllRows(tableName);
                          print('query all rows for $tableName:');
                          allRows.forEach((row) => print(row));
                        });
                      },
                    )
                  ],
                ),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('LOGIN SUCCESS'),
                      Text('Welcome ${user.user_email}'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonRoundedCorner(
                          label: 'Go to Frame',
                          borderColor: Theme.of(context).primaryColor,
                          buttonColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Frame(),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonRoundedCorner(
                          label: 'PRINT ALL DATA',
                          borderColor: Theme.of(context).primaryColor,
                          buttonColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            dbHelper.printAllData();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonRoundedCorner(
                          label: 'Sign Out',
                          borderColor: Theme.of(context).primaryColor,
                          buttonColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            print('Signing out ${widget.user}');
                            await dbHelper.updateSession(
                                0, widget.user.user_email);
                            Navigator.pushNamedAndRemoveUntil(context,
                                '/loginPage', ModalRoute.withName('/'));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : CupertinoActivityIndicator();
      },
    );
    // if (widget.user == null) {
    //   Navigator.of(context).pop();
    //   Fluttertoast.showToast(msg: 'Wrong Password or Email. Please Try Again.');
    //   return Container();
    // } else {
    //   return Scaffold(
    //     appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.transparent,
    //       actions: [
    //         IconButton(
    //           icon: Icon(
    //             Icons.ac_unit,
    //             color: Colors.transparent,
    //           ),
    //           onPressed: () {
    //             List<String> list = [
    //               'tb_user',
    //               'tb_vehicle',
    //               'tb_submission',
    //             ];
    //             list.forEach((tableName) async {
    //               final allRows = await dbHelper.queryAllRows(tableName);
    //               print('query all rows for $tableName:');
    //               allRows.forEach((row) => print(row));
    //             });
    //           },
    //         )
    //       ],
    //     ),
    //     body: Center(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text('LOGIN SUCCESS'),
    //           Text('Welcome ${widget.user.user_email}'),
    //           Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: FutureBuilder<User>(
    //               future: dbHelper.checkSession(),
    //               builder: (context, snapshot) {
    //                 return snapshot.hasData
    //                     ? Text('${snapshot.data.user_email}')
    //                     : CupertinoActivityIndicator();
    //               },
    //             ),
    //           ),
    //           ButtonRoundedCorner(
    //             label: 'PRINT ALL DATA',
    //             borderColor: Theme.of(context).primaryColor,
    //             buttonColor: Theme.of(context).primaryColor,
    //             onPressed: () {
    //               dbHelper.printAllData();
    //             },
    //           ),
    //           ButtonRoundedCorner(
    //             label: 'Sign Out',
    //             borderColor: Theme.of(context).primaryColor,
    //             buttonColor: Theme.of(context).primaryColor,
    //             onPressed: () async {
    //               print('Signing out ${widget.user}');
    //               await dbHelper.updateSession(0, widget.user.user_email);
    //               Navigator.pushNamedAndRemoveUntil(
    //                   context, '/loginPage', ModalRoute.withName('/'));
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}
