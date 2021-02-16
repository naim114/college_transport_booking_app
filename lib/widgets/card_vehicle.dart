import 'package:flutter/material.dart';

import 'package:college_transport_booking_app/models/model_vehicle.dart';
import 'package:college_transport_booking_app/widgets/button_dialog.dart';
import 'package:college_transport_booking_app/widgets/dialog_custom.dart';
import 'package:college_transport_booking_app/widgets/title_and_text.dart';

class CardVehicle extends StatefulWidget {
  const CardVehicle({
    Key key,
    @required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;
  @override
  _CardVehicleState createState() => _CardVehicleState();
}

class _CardVehicleState extends State<CardVehicle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialogVehicleInfo();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          color: Theme.of(context).buttonColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(23.0),
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
        return DialogCustom(
          dialogTitle: 'Vehicle Info',
          contentWidget: [
            SizedBox(width: MediaQuery.of(context).size.width),
            TitleAndText(
              title: 'Vehicle Type',
              text: widget.vehicle.vehicle_type,
            ),
            TitleAndText(
              title: 'Plat Number',
              text: widget.vehicle.plat_no,
            ),
            TitleAndText(
              title: 'Passenger Number',
              text: widget.vehicle.passenger_no.toString(),
            ),
          ],
          footerWidget: [
            //last
            ButtonDialog(
              label: 'Dismiss',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
