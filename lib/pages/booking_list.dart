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
            FutureBuilder<List<Submission>>(
              future: user.head_driver == 1 || user.user_type == 'admin'
                  ? dbHelper.getAllSubmission(
                      submissionStatus: 'Pending',
                    )
                  : dbHelper.getSubmissionByStudentId(
                      studentId: user.user_id,
                      submissionStatus: 'Pending',
                    ),
              builder: (context, snapshot) {
                // print('pending snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
                          Submission pendingSubmission = snapshot.data[index];
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
            FutureBuilder<List<Submission>>(
              future: user.head_driver == 1 || user.user_type == 'admin'
                  ? dbHelper.getAllSubmission(
                      submissionStatus: 'Confirmed',
                    )
                  : user.user_type == 'student'
                      ? dbHelper.getSubmissionByStudentId(
                          studentId: user.user_id,
                          submissionStatus: 'Confirmed',
                        )
                      : dbHelper.getSubmissionByDriverId(
                          driverId: user.user_id,
                          submissionStatus: 'Confirmed',
                        ),
              builder: (context, snapshot) {
                // print('confirm snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
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
            FutureBuilder<List<Submission>>(
              future: user.head_driver == 1 || user.user_type == 'admin'
                  ? dbHelper.getAllSubmission(
                      submissionStatus: 'Completed',
                    )
                  : user.user_type == 'student'
                      ? dbHelper.getSubmissionByStudentId(
                          studentId: user.user_id,
                          submissionStatus: 'Completed',
                        )
                      : dbHelper.getSubmissionByDriverId(
                          driverId: user.user_id,
                          submissionStatus: 'Completed',
                        ),
              builder: (context, snapshot) {
                // print('Completed snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
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
            FutureBuilder<List<Submission>>(
              future: user.head_driver == 1 || user.user_type == 'admin'
                  ? dbHelper.getAllSubmission(
                      submissionStatus: 'Cancelled',
                    )
                  : user.user_type == 'student'
                      ? dbHelper.getSubmissionByStudentId(
                          studentId: user.user_id,
                          submissionStatus: 'Cancelled',
                        )
                      : dbHelper.getSubmissionByDriverId(
                          driverId: user.user_id,
                          submissionStatus: 'Cancelled',
                        ),
              builder: (context, snapshot) {
                // print('Cancelled snapshot: ${snapshot.data}');

                return snapshot.hasData
                    ? ListView(
                        padding: EdgeInsets.all(25),
                        children: List.generate(snapshot.data.length, (index) {
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
          ],
        ),
      ),
    );
  }
}
