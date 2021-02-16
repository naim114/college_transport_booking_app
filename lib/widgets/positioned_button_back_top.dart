import 'package:college_transport_booking_app/widgets/button_back_top.dart';
import 'package:flutter/material.dart';

class PositionedButtonBackTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(top: 40, left: 0, child: ButtonBackTop());
  }
}
