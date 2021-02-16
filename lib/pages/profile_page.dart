import 'package:college_transport_booking_app/pages/edit_profile.dart';
import 'package:college_transport_booking_app/widgets/button_rounded_corner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/models/model_user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'User Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GothicA1Bold',
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .225,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(135)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    user.user_email ?? 'No Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PoppinsBold',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.child_care_rounded),
              title: Text(
                'Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              subtitle: Text(
                user.user_full_name ?? 'No Full Name',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                'Phone Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              subtitle: Text(
                user.user_phone_number ?? 'No Phone Number',
                style: TextStyle(fontSize: 20),
              ),
            ),
            user.user_type == 'student'
                ? ListTile(
                    leading: Icon(Icons.school),
                    title: Text(
                      'Student ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    subtitle: Text(
                      user.student_id ?? 'No Student ID',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : SizedBox(),
            user.user_type == 'student'
                ? ListTile(
                    leading: Icon(Icons.apartment_sharp),
                    title: Text(
                      'Class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    subtitle: Text(
                      user.student_class ?? 'No Class',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : SizedBox(),
            user.user_type == 'student'
                ? ListTile(
                    leading: Icon(Icons.class__sharp),
                    // title: Text('Semester ${user.student_semester.toString()}'),
                    title: Text(
                      'Semester',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    subtitle: Text(
                      user.student_semester.toString() ?? 'No Semester',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ButtonRoundedCorner(
                label: 'Edit Profile Details',
                buttonColor: Theme.of(context).buttonColor,
                borderColor: Theme.of(context).buttonColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => EditProfile(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
