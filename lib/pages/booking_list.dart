import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/booking_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 110.0,
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Booking List',
              style: TextStyle(
                fontFamily: "OpenSansBold",
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          titleSpacing: 12,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            isScrollable: true,
            labelStyle: TextStyle(
              color: Colors.black,
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
            user.head_driver == 1 || user.user_type == 'admin'
                ? FutureBuilder<List<Submission>>(
                    future: dbHelper.getAllSubmission(
                      submissionStatus:
                          user.head_driver == 1 && user.user_type == 'driver'
                              ? 'pending_for_head_driver'
                              : 'Pending',
                    ),
                    builder: (context, snapshot) {
                      print('pending snapshot: ${snapshot.data}');

                      // return Text('${snapshot.data.toString()}');
                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission pendingSubmission =
                                    snapshot.data[index];
                                return BookingCard(
                                  submission: pendingSubmission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  )
                : FutureBuilder<List<Submission>>(
                    future: dbHelper.getSubmissionByStudentId(
                      studentId: user.user_id,
                      submissionStatus: 'Pending',
                    ),
                    builder: (context, snapshot) {
                      print('pending snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission pendingSubmission =
                                    snapshot.data[index];
                                return BookingCard(
                                  submission: pendingSubmission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  ),
            //Confirmed
            user.head_driver == 1 || user.user_type == 'admin'
                ? FutureBuilder<List<Submission>>(
                    future: dbHelper.getAllSubmission(
                        submissionStatus: 'Confirmed'),
                    builder: (context, snapshot) {
                      print('confirm snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission submission = snapshot.data[index];
                                return BookingCard(
                                  submission: submission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  )
                : FutureBuilder<List<Submission>>(
                    future: dbHelper.getSubmissionByStudentId(
                        studentId: user.user_id, submissionStatus: 'Confirmed'),
                    builder: (context, snapshot) {
                      print('confirm snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission submission = snapshot.data[index];
                                return BookingCard(
                                  submission: submission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  ),
            //Completed
            user.head_driver == 1 || user.user_type == 'admin'
                ? FutureBuilder<List<Submission>>(
                    future: dbHelper.getAllSubmission(
                      submissionStatus: 'Completed',
                    ),
                    builder: (context, snapshot) {
                      // print('confirm snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission submission = snapshot.data[index];
                                return BookingCard(
                                  submission: submission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  )
                : FutureBuilder<List<Submission>>(
                    future: dbHelper.getSubmissionByStudentId(
                        studentId: user.user_id, submissionStatus: 'Completed'),
                    builder: (context, snapshot) {
                      // print('completed snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission submission = snapshot.data[index];
                                return BookingCard(
                                  submission: submission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  ),
            //Cancelled/Denied
            user.head_driver == 1 || user.user_type == 'admin'
                ? FutureBuilder<List<Submission>>(
                    future: dbHelper.getAllSubmission(
                      submissionStatus: 'Cancelled',
                    ),
                    builder: (context, snapshot) {
                      // print('confirm snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission submission = snapshot.data[index];
                                return BookingCard(
                                  submission: submission,
                                  user: user,
                                );
                              }),
                            )
                          : Center(child: CupertinoActivityIndicator());
                    },
                  )
                : FutureBuilder<List<Submission>>(
                    future: dbHelper.getSubmissionByStudentId(
                        studentId: user.user_id, submissionStatus: 'Cancelled'),
                    builder: (context, snapshot) {
                      // print('cancelled snapshot: ${snapshot.data}');

                      return snapshot.hasData
                          ? ListView(
                              padding: EdgeInsets.all(25),
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                Submission submission = snapshot.data[index];
                                return BookingCard(
                                  submission: submission,
                                  user: user,
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
