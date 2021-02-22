import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:college_transport_booking_app/models/model_user.dart';
import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:college_transport_booking_app/widgets/title_and_text.dart';

class CardVehicle extends StatefulWidget {
  CardVehicle({
    Key key,
    @required this.vehicle,
    @required this.user,
  }) : super(key: key);

  final Vehicle vehicle;
  final User user;
  @override
  _CardVehicleState createState() => _CardVehicleState();
}

String dropdownValue = 'Bus';

class _CardVehicleState extends State<CardVehicle> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialogVehicleInfo();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          color: Theme.of(context).buttonColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(23.0),
            child: Container(
              width: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.emoji_transportation,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 15)),
                        TextSpan(
                          text: widget.vehicle.plat_no,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showDialogVehicleInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String vehicleType = widget.vehicle.vehicle_type;
        return DialogCustom(
          dialogTitle: 'Vehicle Info',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            TitleAndText(
              title: 'Vehicle Type',
              text:
                  '${vehicleType[0].toUpperCase()}${vehicleType.substring(1)}',
            ),
            TitleAndText(
              title: 'Plat Number',
              text: widget.vehicle.plat_no,
            ),
            TitleAndText(
              title: 'Passenger Number (Capacity)',
              text: widget.vehicle.passenger_no.toString(),
            ),
          ],
          footerWidget: [
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            widget.user.user_type == 'admin' || widget.user.head_driver == 1
                ? ButtonDialog(
                    label: 'Edit',
                    fontColor: Theme.of(context).buttonColor,
                    onPressed: () {
                      showDialogManageVehicleInfo();
                    },
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }

  showDialogManageVehicleInfo() {
    final TextEditingController _contPlatNo =
        TextEditingController(text: widget.vehicle.plat_no);
    final TextEditingController _contPassengerNo =
        TextEditingController(text: widget.vehicle.passenger_no.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          dialogTitle: 'Edit Vehicle Info',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter dropDownState) {
                return Container(
                  width: double.infinity,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Vechicle Type',
                      hintText: 'Vechicle Type',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.arrow_downward),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          dropdownValue = newValue;
                          dropDownState(() {
                            dropdownValue = newValue;
                            print(
                                'new value: $newValue ==> dropdown value: $dropdownValue');
                          });
                        },
                        items: <String>['Bus', 'Van']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: dropdownValue,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Plat Number",
                ),
                controller: _contPlatNo,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Passenger Number (Capacity)",
                ),
                controller: _contPassengerNo,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              label: 'Apply Changes',
              fontColor: Theme.of(context).buttonColor,
              onPressed: () {
                Map<String, dynamic> dataMap = {
                  DatabaseHelper.vehicle_type: dropdownValue,
                  DatabaseHelper.plat_no: _contPlatNo.text,
                  DatabaseHelper.passenger_no: _contPassengerNo.text,
                };

                print('vehicle_id: ${widget.vehicle.vehicle_id}');
                dataMap.forEach((key, value) {
                  print('$key => $value');
                });

                dbHelper.updateByHelperCustom(
                  DatabaseHelper.tb_vehicle,
                  DatabaseHelper.vehicle_id,
                  widget.vehicle.vehicle_id,
                  dataMap,
                );

                Fluttertoast.showToast(msg: 'Vehicle info changes successful!');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
