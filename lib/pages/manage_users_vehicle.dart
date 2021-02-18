import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/card_user.dart';
import 'package:college_transport_booking_app/widgets/card_vehicle.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';

class ManageUsersVehicles extends StatefulWidget {
  final User currentUser;

  const ManageUsersVehicles({
    Key key,
    @required this.currentUser,
  }) : super(key: key);

  @override
  _ManageUsersVehiclesState createState() => _ManageUsersVehiclesState();
}

String dropdownValue = 'Bus';

class _ManageUsersVehiclesState extends State<ManageUsersVehicles> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    print('xx current user: ${widget.currentUser}');
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 110.0,
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Manage Users & Vehicle',
            ),
          ),
          titleSpacing: 12,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            tabs: [
              Tab(text: "Student"),
              Tab(text: "Driver"),
              Tab(text: "Vehicle"),
              Tab(text: "Admin"),
            ],
            indicatorColor: Theme.of(context).primaryColor,
          ),
        ),
        floatingActionButton: FabCircularMenu(
          fabColor: Colors.indigo[900],
          fabOpenColor: Colors.indigo[900],
          fabOpenIcon: Icon(Icons.add, color: Colors.white),
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          fabCloseColor: Colors.indigo[900],
          ringColor: Theme.of(context).accentColor,
          children: <Widget>[
            Tooltip(
              message: 'Add Driver',
              child: IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  showDialogAddDriver();
                },
              ),
            ),
            widget.currentUser.super_admin == 1
                ? Tooltip(
                    message: 'Add Admin',
                    child: IconButton(
                      icon: Icon(Icons.admin_panel_settings_outlined),
                      onPressed: () {
                        showDialogAddAdmin();
                      },
                    ),
                  )
                : SizedBox.shrink(),
            Tooltip(
              message: 'Add Vehicle',
              child: IconButton(
                icon: Icon(Icons.car_repair),
                onPressed: () {
                  showDialogAddVehicle();
                },
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Student
            widget.currentUser.user_type == 'admin'
                ? FutureBuilder<List<User>>(
                    future: dbHelper.getUserListByType('student'),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                User student = snapshot.data[index];
                                print('data map index no $index: $student');
                                // return Text('$student');
                                return CardUser(
                                  user: student,
                                  currentUser: widget.currentUser,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  )
                : Center(child: Text('Sorry! Only admin can view this list')),
            //Driver
            FutureBuilder<List<User>>(
              future: dbHelper.getUserListByType('driver'),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          User driver = snapshot.data[index];
                          return CardUser(
                            user: driver,
                            currentUser: widget.currentUser,
                          );
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Vehicle
            FutureBuilder<List<Vehicle>>(
              future: dbHelper.getAllVehicle(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Vehicle vehicle = snapshot.data[index];
                          return CardVehicle(
                            vehicle: vehicle,
                            user: widget.currentUser,
                          );
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Admin
            widget.currentUser.user_type == 'admin' &&
                    widget.currentUser.super_admin == 1
                ? FutureBuilder<List<User>>(
                    future: dbHelper.getUserListByType('admin'),
                    builder: (context, snapshot) {
                      print('admin snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                User driver = snapshot.data[index];
                                return CardUser(
                                  user: driver,
                                  currentUser: widget.currentUser,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  )
                : Center(
                    child: Text('Sorry! Only super admin can view this list')),
          ],
        ),
      ),
    );
  }

  showDialogAddVehicle() {
    TextEditingController _contPlatNo = TextEditingController();
    TextEditingController _contPassengerNo = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Add Vehicle',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter dropDownState) {
                return Container(
                  width: double.infinity,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Vechicle Type',
                      hintText: 'Vechicle Type',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.arrow_downward),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          dropdownValue = newValue;
                          dropDownState(() {
                            dropdownValue = newValue;
                            print(
                                'new value: $newValue ==> dropdown value: $dropdownValue');
                          });
                        },
                        items: <String>['Bus', 'Van']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: dropdownValue,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Plat Number",
                ),
                controller: _contPlatNo,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Passenger Number",
                ),
                controller: _contPassengerNo,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              label: 'Add Vehicle',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () async {
                Map<String, dynamic> dataMap = {
                  DatabaseHelper.vehicle_type: dropdownValue,
                  DatabaseHelper.plat_no: _contPlatNo.text,
                  DatabaseHelper.passenger_no: _contPassengerNo.text,
                };

                print('///////////////dataMap//////////////');
                dataMap.forEach((key, value) {
                  print('$key => $value');
                });
                print('///////////////dataMap//////////////');

                final id = await dbHelper.insert(
                  DatabaseHelper.tb_vehicle,
                  dataMap,
                );
                print('Inserted row id to tb_vehicle $id successful');

                Fluttertoast.showToast(
                    msg: 'Add vehicle ${_contPlatNo.text} successful!');
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

  showDialogAddDriver() {
    TextEditingController contFullName = TextEditingController();
    TextEditingController contEmail = TextEditingController();
    TextEditingController contPhoneNumber = TextEditingController();
    TextEditingController contPassword = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Add Driver',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                ),
                controller: contFullName,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                controller: contEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                ),
                controller: contPhoneNumber,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                controller: contPassword,
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
              label: 'Add Driver',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () async {
                if (!contEmail.text.contains('@')) {
                  Fluttertoast.showToast(
                      msg: 'Please enter correct email format');
                  print('SHANGRI-LA ERROR: email format incorrect');
                  return false;
                }

                Map<String, dynamic> dataMap = {
                  DatabaseHelper.user_full_name: contFullName.text,
                  DatabaseHelper.user_email: contEmail.text,
                  DatabaseHelper.user_phone_number: contPhoneNumber.text,
                  DatabaseHelper.password: contPassword.text,
                  DatabaseHelper.user_type: 'driver',
                };

                print('///////////////dataMap//////////////');
                dataMap.forEach((key, value) {
                  print('$key => $value');
                });
                print('////////////////dataMap/////////////');

                final id = await dbHelper.insert(
                  DatabaseHelper.tb_user,
                  dataMap,
                );
                print('Inserted row id to tb_vehicle $id successful');

                Fluttertoast.showToast(
                    msg: 'Add driver ${contEmail.text} successful!');
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

  showDialogAddAdmin() {
    TextEditingController contFullName = TextEditingController();
    TextEditingController contEmail = TextEditingController();
    TextEditingController contPhoneNumber = TextEditingController();
    TextEditingController contPassword = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Add Admin',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                ),
                controller: contFullName,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                controller: contEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                ),
                controller: contPhoneNumber,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                controller: contPassword,
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
              label: 'Add Admin',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () async {
                if (!contEmail.text.contains('@')) {
                  Fluttertoast.showToast(
                      msg: 'Please enter correct email format');
                  print('SHANGRI-LA ERROR: email format incorrect');
                  return false;
                }

                Map<String, dynamic> dataMap = {
                  DatabaseHelper.user_full_name: contFullName.text,
                  DatabaseHelper.user_email: contEmail.text,
                  DatabaseHelper.user_phone_number: contPhoneNumber.text,
                  DatabaseHelper.password: contPassword.text,
                  DatabaseHelper.user_type: 'admin',
                };

                print('///////////////dataMap//////////////');
                dataMap.forEach((key, value) {
                  print('$key => $value');
                });
                print('////////////////dataMap/////////////');

                final id = await dbHelper.insert(
                  DatabaseHelper.tb_user,
                  dataMap,
                );
                print('Inserted row id to tb_vehicle $id successful');

                Fluttertoast.showToast(
                    msg: 'Add admin ${contEmail.text} successful!');
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
