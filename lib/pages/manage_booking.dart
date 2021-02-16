import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/booking_card.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _ManageBookingState createState() => _ManageBookingState();
  final User user;
}

class _ManageBookingState extends State<ManageBooking> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 110.0,
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Manage Booking',
            ),
          ),
          titleSpacing: 12,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            labelColor: Colors.white,
            isScrollable: true,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Confirmed"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled/Denied"),
            ],
            indicatorColor: Theme.of(context).primaryColor,
          ),
        ),
        body: TabBarView(
          children: [
            // Pending
            FutureBuilder<List<Submission>>(
              future: dbHelper.getAllSubmissionByStatus(),
              builder: (context, snapshot) {
                print('pending snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Submission pendingSubmission = snapshot.data[index];
                          print('data map index no $index: $pendingSubmission');
                          return BookingCard(
                            submission: pendingSubmission,
                            user: widget.user,
                          );
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Confirmed
            FutureBuilder<List<Submission>>(
              future: dbHelper.getAllSubmissionByStatus(subStatus: 'Confirmed'),
              builder: (context, snapshot) {
                print('confirm snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Submission submission = snapshot.data[index];
                          return BookingCard(
                            submission: submission,
                            user: widget.user,
                          );
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Completed
            FutureBuilder<List<Submission>>(
              future: dbHelper.getAllSubmissionByStatus(subStatus: 'Completed'),
              builder: (context, snapshot) {
                print('completed snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Submission submission = snapshot.data[index];
                          return BookingCard(
                            submission: submission,
                            user: widget.user,
                          );
                        }),
                      )
                    : Center(child: CupertinoActivityIndicator());
              },
            ),
            //Cancelled/Denied
            FutureBuilder<List<Submission>>(
              future: dbHelper.getAllSubmissionByStatus(subStatus: 'Cancelled'),
              builder: (context, snapshot) {
                print('cancelled snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Submission submission = snapshot.data[index];
                          return BookingCard(
                            submission: submission,
                            user: widget.user,
                          );
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
