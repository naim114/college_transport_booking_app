import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key key,
  }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final dbHelper = DatabaseHelper.instance;

  final contSubmissionLocation = TextEditingController();
  final contPersonNum = TextEditingController();
  final contCompanionName = TextEditingController();
  final contCompanionPhoneNumber = TextEditingController();
  final contCompanionEmail = TextEditingController();
  DateTime _selectedDateCollegeToLocation = DateTime.now();
  DateTime _selectedDateLocationToCollege = DateTime.now();
  // final date_time_departure_to_location = TextEditingController();
  // final date_time_departure_from_location = TextEditingController();

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      // _selectedDay.add(Duration(days: 22)): [
      //   'Event A13',
      //   'Event B13',
      // ],
      // _selectedDay.add(Duration(days: 26)): [
      //   'Event A14',
      //   'Event B14',
      //   'Event C14'
      // ],
      DateTime(2021, 2, 13): ['summer depression, its summer here everyday'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    contSubmissionLocation.dispose();
    contPersonNum.dispose();
    contCompanionName.dispose();
    contCompanionPhoneNumber.dispose();
    contCompanionEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    print('current user: $user');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'PoppinsBold',
              fontSize: 25,
            ),
            children: [
              TextSpan(text: 'C', style: TextStyle(color: Colors.white)),
              TextSpan(text: 'TBA'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonColor,
        tooltip: 'Create and trip submission',
        child: Icon(
          Icons.add_to_photos,
          color: Colors.white,
        ),
        onPressed: () {
          showDialogCreateSubmission(user);
        },
      ),
      body: Column(
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
      ),
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
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map(
            (event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: Text(event.toString()),
                onTap: () => print('$event tapped!'),
              ),
            ),
          )
          .toList(),
    );
  }

  showDialogCreateSubmission(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // String formattedDateCollegeToLocation = DateFormat('dd/MM/yyyy – kk:mm')
        //     .format(_selectedDateCollegeToLocation);
        // String formattedDateLocationToCollege = DateFormat('dd/MM/yyyy – kk:mm')
        //     .format(_selectedDateLocationToCollege);

        return DialogCustom(
          dialogColor: Theme.of(context).buttonColor,
          dialogTitle: 'Trip Submission Form',
          contentWidget: [
            Text(
              'Note: Your submission need to be approved first before it totally confirmed.',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Trip Location",
                ),
                autofocus: true,
                controller: contSubmissionLocation,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Number of Passenger",
                ),
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: contPersonNum,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Companion Name (Lecturer, College Staff, etc..)",
                ),
                controller: contCompanionName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Companion Phone Number",
                ),
                controller: contCompanionPhoneNumber,
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Companion Email",
                ),
                controller: contCompanionEmail,
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
              label: 'Continue',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                if (contSubmissionLocation.text == '' ||
                    contPersonNum.text == '' ||
                    contCompanionName.text == '' ||
                    contCompanionPhoneNumber.text == '' ||
                    contCompanionEmail.text == '') {
                  Fluttertoast.showToast(msg: 'Please fill in all details');
                  print('SHANGRI-LA ERROR: some textfield not filled!');
                  return false;
                }
                if (contCompanionEmail.text.contains(" ")) {
                  Fluttertoast.showToast(msg: 'There can be whitespace email!');
                  print('SHANGRI-LA ERROR: id or email has whitespace!');
                  return false;
                }
                if (!contCompanionEmail.text.contains('@')) {
                  Fluttertoast.showToast(
                      msg: 'Please enter correct email format');
                  print('SHANGRI-LA ERROR: email format incorrect');
                  return false;
                }

                _selectDateCollegeToLocation(context, user);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDateCollegeToLocation(
    BuildContext context,
    User user,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      helpText: 'Departure From College to Location',
      confirmText: 'Continue'.toUpperCase(),
      fieldLabelText: 'Departure From College to Location',
    );
    if (picked != null && picked != _selectedDateCollegeToLocation) {
      setState(() {
        _selectedDateCollegeToLocation = DateTime(
          picked.year,
          picked.month,
          picked.day,
          picked.hour,
          picked.minute,
        );
      });
      print('_selectedDateCollegeToLocation: $_selectedDateCollegeToLocation');
      _selectDateLocationToCollege(context, user);
    }
  }

  Future<void> _selectDateLocationToCollege(
    BuildContext context,
    User user,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      helpText: 'Departure From Location to College',
      confirmText: 'Submit Trip Form'.toUpperCase(),
    );
    if (picked != null && picked != _selectedDateLocationToCollege) {
      setState(() {
        _selectedDateLocationToCollege = DateTime(
          picked.year,
          picked.month,
          picked.day,
          picked.hour,
          picked.minute,
        );
      });
      print('_selectedDateCollegeToLocation: $_selectedDateLocationToCollege');

      Map<String, dynamic> dataRow = {
        // DatabaseHelper.user_type: 'student',
        DatabaseHelper.submission_location: contSubmissionLocation.text,
        DatabaseHelper.person_num: contPersonNum.text,
        DatabaseHelper.companion_name: contCompanionName.text,
        DatabaseHelper.companion_phone_no: contCompanionPhoneNumber.text,
        DatabaseHelper.companion_email: contCompanionEmail.text,
        DatabaseHelper.submission_student_id: user.user_id,
        DatabaseHelper.date_time_departure_to_location:
            DateFormat('dd/MM/yyyy – kk:mm')
                .format(_selectedDateCollegeToLocation)
                .toString(),
        DatabaseHelper.date_time_departure_from_location:
            DateFormat('dd/MM/yyyy – kk:mm')
                .format(_selectedDateLocationToCollege)
                .toString(),
      };
      print('/////////data row/////////');
      dataRow.forEach((key, value) {
        print('$key: $value');
      });
      print('/////////data row/////////');
      final id = await dbHelper.insert(DatabaseHelper.tb_submission, dataRow);
      print('Inserted row id to tb_submission $id successful');
      Fluttertoast.showToast(
          msg: 'Trip form submission sucessfully submitted!');
      Navigator.of(context).pop();
    }
  }
}
