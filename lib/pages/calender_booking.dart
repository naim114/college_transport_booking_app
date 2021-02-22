import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:college_transport_booking_app/models/model_user.dart';

class CalenderBooking extends StatefulWidget {
  final User user;

  const CalenderBooking({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _CalenderBookingState createState() => _CalenderBookingState();
}

class _CalenderBookingState extends State<CalenderBooking>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final dbHelper = DatabaseHelper.instance;

  List<Submission> subList;

  @override
  initState() {
    // _events[DateTime.parse('2021-02-17')] = [
    //   'wanda jackson',
    //   'sister rosetta tharpe',
    // ];
    // Future.delayed(Duration.zero, () => _getConfirmedTripForCalender());
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _getConfirmedTripForCalender());
    _getConfirmedTripForCalender();
    // List<dynamic> listToAdd = _events[DateTime.parse('2021-02-17')];

    // listToAdd.add('garland');

    final _selectedDay = DateTime.now();
    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  Future<void> _getConfirmedTripForCalender() async {
    //JUST DONT DELETE THESE SHIT
    // dbHelper
    //     .getSubmissionByStudentId(
    //         studentId: widget.user.user_id, submissionStatus: 'Pending')
    //     .then((submissionList) {
    //   submissionList.forEach((sub) {
    //     print('before parse: $sub');
    //     DateTime subDateTime =
    //         DateTime.parse(sub.date_time_departure_to_location);
    //     DateTime reformatDate =
    //         DateTime(subDateTime.year, subDateTime.month, subDateTime.day);
    //     // print('sub: ${sub.date_time_departure_to_location}');
    //     // print(
    //     //     'sub datetime: ${DateTime.parse(sub.date_time_departure_to_location)}');
    //     // print('sub datetime reformat: ${reformatDate.toString()}');

    //     //FINISH THIS SHIT
    //     _events.forEach((key, value) {
    //       // print('key: $key');
    //       print('sub datetime reformat: ${reformatDate.toString()}');
    //       if (reformatDate == DateTime(key.year, key.month, key.day)) {
    //         //masuk sini error
    //         print('enter if');
    //         print('condition $reformatDate equal to $key');
    //         List<dynamic> listToAdd = _events[key];
    //         listToAdd.add(sub.submission_location);
    //       } else {
    //         //dah betul dah
    //         print('enter else');
    //         setState(() {
    //           _events[reformatDate] = [sub.submission_location];
    //         });
    //         print('ending else ${_events[reformatDate]}');
    //       }

    //       // print('eureka: $key ==> ${_events[key]}');
    //     });
    //     print('tak lalu pon');

    //     // _events[reformatDate] = [sub.submission_location];
    //     // print('_events[reformatDate]: ${_events[reformatDate]}');
    //   });
    // });

    //FUCKKKKKKKKKKKKK
    // _events.forEach((key, value) {
    //   // print('key: $key');
    //   dbHelper
    //       .getSubmissionByStudentId(
    //           studentId: widget.user.user_id,
    //           submissionStatus: 'Pending'
    //           )
    //       .then((subList) {
    //     subList.forEach((sub) {
    //       DateTime subDateTime =
    //           DateTime.parse(sub.date_time_departure_to_location);
    //       DateTime reformatDate =
    //           DateTime(subDateTime.year, subDateTime.month, subDateTime.day);

    //       if (key == null) {
    //         _events[reformatDate] = [sub.submission_location];
    //       }

    //       print('sub datetime reformat: ${reformatDate.toString()}');
    //
    //       print('is it really $reformatDate equal to $key');

    //       if (reformatDate == DateTime(key.year, key.month, key.day)) {
    //         //masuk sini error
    //         print('enter if');
    //         print('condition $reformatDate equal to $key');
    //         List<dynamic> listToAdd = _events[key];
    //         listToAdd.add(sub.submission_location);
    //       } else {
    //         //dah betul dah
    //         print('enter else');
    //         setState(() {
    //           _events[reformatDate] = [sub.submission_location];
    //         });
    //         print('ending else ${_events[reformatDate]}');
    //       }

    //       print('eureka: $key ==> ${_events[key]}');
    //     });
    //   });
    // });

    // List<dynamic> nobodyGonnaTaughtYouHowToLiveInTheStreets =
    //     _events[DateTime.parse('2021-02-17')];
    // nobodyGonnaTaughtYouHowToLiveInTheStreets.add('judy garland');

    print('entering the one of many void in my brain');

    List<Submission> subList = [];

    if (widget.user.user_type == 'admin' || widget.user.head_driver == 1) {
      print('is an admin or head driver');
      subList = await dbHelper.getAllSubmission(submissionStatus: 'Confirmed');
    } else if (widget.user.user_type == 'student') {
      print('is a student');
      subList = await dbHelper.getSubmissionByStudentId(
          studentId: widget.user.user_id, submissionStatus: 'Confirmed');
    } else if (widget.user.user_type == 'driver') {
      print('is a driver');
      subList = await dbHelper.getSubmissionByDriverId(
          driverId: widget.user.user_id, submissionStatus: 'Confirmed');
    }

    print('subList: $subList');

    if (_events.isEmpty && subList.isNotEmpty) {
      print('this map is empty');
      DateTime subDateTime =
          DateTime.parse(subList.first.date_time_departure_to_location);
      DateTime reformatDate =
          DateTime(subDateTime.year, subDateTime.month, subDateTime.day);

      // ACTIONS _events[reformatDate] = [subList.first];
      setState(() {
        _events[reformatDate] = [subList.first];
      });
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   setState(() {
      //     _events[reformatDate] = [subList.first];
      //   });
      // });

      // Future.delayed(Duration.zero, () => _getConfirmedTripForCalender());
      // WidgetsBinding.instance
      //     .addPostFrameCallback((_) => _events[reformatDate] = [subList.first]);
    }
    _events.forEach((key, value) {
      subList.forEach((sub) {
        // List<dynamic> listToAdd = _events[key];

        DateTime subDateTime =
            DateTime.parse(sub.date_time_departure_to_location);
        DateTime reformatDate =
            DateTime(subDateTime.year, subDateTime.month, subDateTime.day);
        if (reformatDate == DateTime(key.year, key.month, key.day)) {
          print('same date!');
          print('list that have the same date: ${_events[key]}');

          if (!_events[key].contains(sub)) {
            // setState(() {
            // ACTIONS _events[key].add(sub);
            // WidgetsBinding.instance
            //     .addPostFrameCallback((_) => _events[key].add(sub));

            setState(() {
              _events[key].add(sub);
            });

            // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            //       _events[key].add(sub);
            //     }));
            print('list after add: $_events[key]');
            // });
          }
        } else {
          // print('enter else (not the same date)');
          // setState(() {
          // ACTIONS _events[reformatDate] = [sub];
          // WidgetsBinding.instance
          //     .addPostFrameCallback((_) => _events[reformatDate] = [sub]);

          setState(() {
            _events[reformatDate] = [sub];
          });

          // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          //       _events[reformatDate] = [sub];
          //     }));
          // });
        }
      });
    });

    print('_events = $_events');
  }

  @override
  Widget build(BuildContext context) {
    // print('sister rosetta tharpe: ${widget.user}');
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'View all your confirmed trip here. You can create and trip submission by tapping on the floating button.',
            style: TextStyle(
              fontFamily: 'GothicA1Bold',
              fontSize: 15,
            ),
          ),
        ),
        _buildTableCalendar(),
        SizedBox(height: 8.0),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      onDaySelected: _onDaySelected,
      // onVisibleDaysChanged: _onVisibleDaysChanged,
      // onCalendarCreated: _onCalendarCreated,
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    // print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  // void _onCalendarCreated(
  //     DateTime first, DateTime last, CalendarFormat format) {
  //   // print('CALLBACK: _onCalendarCreated');
  //   if (DateTime.now() == DateTime.now()) {
  //     print('it is today!');
  //   }
  //   _onDaySelected()
  // }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents.map(
        (event) {
          if (event.runtimeType == Submission) {
            // print('event runtimeType: ${event.runtimeType}');
            Submission sub = event;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BookingCard(
                submission: sub,
                user: widget.user,
                cardColor: Theme.of(context).buttonColor,
                iconColor: Colors.white,
                textColor: Colors.white,
              ),
            );
            // return Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 0.8,
            //       color: Theme.of(context).buttonColor,
            //     ),
            //     borderRadius: BorderRadius.circular(12.0),
            //     color: Theme.of(context).buttonColor,
            //   ),
            //   margin:
            //       const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            //   child: ListTile(
            //     title: RichText(
            //       textAlign: TextAlign.justify,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       text: TextSpan(
            //         style: TextStyle(color: Colors.white),
            //         children: [
            //           WidgetSpan(
            //             child: Icon(
            //               Icons.location_on,
            //               color: Colors.white,
            //               size: 18,
            //             ),
            //           ),
            //           WidgetSpan(child: SizedBox(width: 7)),
            //           TextSpan(
            //             text: sub.submission_location,
            //           ),
            //         ],
            //       ),
            //     ),
            //     onTap: () => print('$event tapped!'),
            //   ),
            // );
          }
        },
      ).toList(),
    );
  }
}
