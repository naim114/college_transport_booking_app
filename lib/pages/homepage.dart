import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/pages/calender_booking.dart';
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
  final dbHelper = DatabaseHelper.instance;

  final contSubmissionLocation = TextEditingController();
  final contPersonNum = TextEditingController();
  final contCompanionName = TextEditingController();
  final contCompanionPhoneNumber = TextEditingController();
  final contCompanionEmail = TextEditingController();
  DateTime _selectedDateCollegeToLocation = DateTime.now();
  DateTime _selectedTimeCollegeToLocation = DateTime.now();
  DateTime _selectedDateLocationToCollege = DateTime.now();
  DateTime _selectedTimeLocationToCollege = DateTime.now();

  @override
  void dispose() {
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
    // print('current user: $user');
    // print('xx current user: $currentUser');
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
      floatingActionButton: user.user_type == 'student'
          ? FloatingActionButton(
              backgroundColor: Colors.indigo[900],
              tooltip: 'Create and trip submission',
              child: Icon(
                Icons.add_to_photos,
                color: Colors.white,
              ),
              onPressed: () {
                showDialogCreateSubmission(user);
              },
            )
          : SizedBox.shrink(),
      body: user.user_id != 0
          ? CalenderBooking(user: user)
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  showDialogCreateSubmission(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // String formattedDateCollegeToLocation = DateFormat('yyyy-MM-dd')
        //     .format(_selectedDateCollegeToLocation);
        // String formattedDateLocationToCollege = DateFormat('yyyy-MM-dd')
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
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now().add(Duration(days: 7)),
      lastDate: DateTime(2101),
      helpText: 'Departure From College to Location',
      confirmText: 'Continue'.toUpperCase(),
      fieldLabelText: 'Departure From College to Location',
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pinkAccent,
            accentColor: Colors.pinkAccent,
            colorScheme: ColorScheme.light(primary: Colors.pinkAccent),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != _selectedDateCollegeToLocation) {
      setState(() {
        _selectedDateCollegeToLocation = DateTime(
          picked.year,
          picked.month,
          picked.day,
        );
      });
      // _selectDateLocationToCollege(context, user);
    }
    print('_selectedDateCollegeToLocation: $_selectedDateCollegeToLocation');
    _selectTimeCollegeToLocation(context, user);
  }

  Future<void> _selectTimeCollegeToLocation(
    BuildContext context,
    User user,
  ) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      helpText: 'Departure From College to Location',
      confirmText: 'Continue'.toUpperCase(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pinkAccent,
            accentColor: Colors.pinkAccent,
            colorScheme: ColorScheme.light(primary: Colors.pinkAccent),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      initialTime: TimeOfDay(
          hour: _selectedTimeCollegeToLocation.hour,
          minute: _selectedTimeCollegeToLocation.minute),
    );
    if (picked != null &&
        picked !=
            TimeOfDay(
                hour: _selectedTimeCollegeToLocation.hour,
                minute: _selectedTimeCollegeToLocation.minute)) {
      setState(() {
        _selectedTimeCollegeToLocation = DateTime(
          picked.hour,
          picked.minute,
        );
      });
    }
    print('_selectedTimeCollegeToLocation: $_selectedTimeCollegeToLocation');
    _selectDateLocationToCollege(context, user);
  }

  Future<void> _selectDateLocationToCollege(
    BuildContext context,
    User user,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now().add(Duration(days: 7)),
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
        );
      });
    }
    print('_selectDateLocationToCollege: $_selectedDateLocationToCollege');
    _selectTimeLocationToCollege(context, user);
  }

  Future<void> _selectTimeLocationToCollege(
    BuildContext context,
    User user,
  ) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      helpText: 'Departure From Location to College',
      confirmText: 'Continue'.toUpperCase(),
      initialTime: TimeOfDay(
          hour: _selectedTimeLocationToCollege.hour,
          minute: _selectedTimeLocationToCollege.minute),
    );
    if (picked != null &&
        picked !=
            TimeOfDay(
                hour: _selectedTimeLocationToCollege.hour,
                minute: _selectedTimeLocationToCollege.minute)) {
      setState(() {
        _selectedTimeLocationToCollege = DateTime(
          picked.hour,
          picked.minute,
        );
      });
    }
    print('_selectedTimeLocationToCollege: $_selectedTimeLocationToCollege');

    DateTime selectedDateTimeGo = DateTime(
      _selectedDateCollegeToLocation.year,
      _selectedDateCollegeToLocation.month,
      _selectedDateCollegeToLocation.day,
      _selectedTimeCollegeToLocation.hour,
      _selectedTimeCollegeToLocation.minute,
    );

    DateTime selectedDateTimeBack = DateTime(
      _selectedDateLocationToCollege.year,
      _selectedDateLocationToCollege.month,
      _selectedDateLocationToCollege.day,
      _selectedTimeLocationToCollege.hour,
      _selectedTimeLocationToCollege.minute,
    );

    print('selectedDateTimeGo: $selectedDateTimeGo');
    print('selectedDateTimeBack: $selectedDateTimeBack');

    print(
        'selectedDateTimeGo reformat: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTimeGo)}');
    print(
        'selectedDateTimeBack reformat: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTimeBack)}');

    Map<String, dynamic> dataRow = {
      // DatabaseHelper.user_type: 'student',
      DatabaseHelper.submission_location: contSubmissionLocation.text,
      DatabaseHelper.person_num: contPersonNum.text,
      DatabaseHelper.companion_name: contCompanionName.text,
      DatabaseHelper.companion_phone_no: contCompanionPhoneNumber.text,
      DatabaseHelper.companion_email: contCompanionEmail.text,
      DatabaseHelper.submission_student_id: user.user_id,
      DatabaseHelper.date_time_departure_to_location:
          DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTimeGo).toString(),
      DatabaseHelper.date_time_departure_from_location:
          DateFormat('yyyy-MM-dd HH:mm')
              .format(selectedDateTimeBack)
              .toString(),
    };
    print('/////////data row/////////');
    dataRow.forEach((key, value) {
      print('$key: $value');
    });
    print('/////////data row/////////');
    final id = await dbHelper.insert(DatabaseHelper.tb_submission, dataRow);
    print('Inserted row id to tb_submission $id successful');
    Fluttertoast.showToast(msg: 'Trip form submission sucessfully submitted!');
    // Navigator.of(context).pop();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      ModalRoute.withName('/'),
    );
  }
}
