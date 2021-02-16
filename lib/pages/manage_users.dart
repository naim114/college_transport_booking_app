import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/booking_card.dart';
import 'package:college_transport_booking_app/widgets/card_user.dart';
import 'package:college_transport_booking_app/widgets/card_vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageUsers extends StatelessWidget {
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
