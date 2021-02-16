import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final double fontSize;
  final Color titleColor, color;

  const AppTitle({
    Key key,
    this.fontSize = 25,
    this.titleColor = Colors.black,
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'College',
          style: TextStyle(
            color: titleColor,
            fontSize: fontSize,
            fontFamily: 'PoppinsBold',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Transportation',
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: 'PoppinsBold',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Booking App',
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: 'PoppinsBold',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
