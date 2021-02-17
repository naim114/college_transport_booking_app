import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/card_user.dart';
import 'package:college_transport_booking_app/widgets/card_vehicle.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageUsersVehicles extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                  print('Add Driver');
                },
              ),
            ),
            Tooltip(
              message: 'Add Vehicle',
              child: IconButton(
                icon: Icon(Icons.car_repair),
                onPressed: () {
                  print('Add Vehicle');
                },
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            // Student
            FutureBuilder<List<User>>(
              future: dbHelper.getUserListByType('student'),
              builder: (context, snapshot) {
                // print('student snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          User student = snapshot.data[index];
                          print('data map index no $index: $student');
                          // return Text('$student');
                          return CardUser(user: student);
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Driver
            FutureBuilder<List<User>>(
              future: dbHelper.getUserListByType('driver'),
              builder: (context, snapshot) {
                // print('confirm snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          User driver = snapshot.data[index];
                          return CardUser(user: driver);
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Vehicle
            FutureBuilder<List<Vehicle>>(
              future: dbHelper.getAllVehicle(),
              builder: (context, snapshot) {
                // print('getAllVehicle snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Vehicle vehicle = snapshot.data[index];
                          return CardVehicle(vehicle: vehicle);
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
