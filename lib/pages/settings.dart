import 'package:college_transport_booking_app/models/model_submission.dart';
import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/pages/manage_booking.dart';
import 'package:college_transport_booking_app/pages/manage_users_vehicle.dart';
import 'package:college_transport_booking_app/pages/profile_page.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/services/function_helper.dart';
import 'package:college_transport_booking_app/widgets/app_title.dart';
import 'package:college_transport_booking_app/widgets/button_icon_rounded_corner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final User user = Provider.of<User>(context);
    final dbHelper = DatabaseHelper.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'GothicA1Bold',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.black,
            ),
            onPressed: () {
              dbHelper.printAllData();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.blue,
            ),
            onPressed: () async {
              print('current user id ${user.user_id}');
              List<Submission> newSub = await dbHelper.getSubmissionByStudentId(
                studentId: user.user_id,
              );
              print('newSub: ${newSub.toString()}');
            },
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
              child: AppTitle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
              ),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Tooltip(
                    message: 'User Profile',
                    child: ButtonIconRoundedCorner(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProfilePage(user: user),
                          ),
                        );
                      },
                    ),
                  ),
                  user.user_type == 'admin'
                      ? Tooltip(
                          message: 'Manage Booking',
                          child: ButtonIconRoundedCorner(
                            icon: Icon(
                              Icons.list_alt,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ManageBooking(user: user),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                  user.user_type == 'admin'
                      ? Tooltip(
                          message: 'Manage Users & Vehicle',
                          child: ButtonIconRoundedCorner(
                            icon: Icon(
                              Icons.people_rounded,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ManageUsersVehicles(),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                  Tooltip(
                    message: 'Log Out',
                    child: ButtonIconRoundedCorner(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      borderColor: Colors.redAccent,
                      buttonColor: Colors.red,
                      onTap: () async {
                        FunctionHelper.instance.logOut(user, context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
