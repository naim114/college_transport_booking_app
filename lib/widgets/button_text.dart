import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final List<Color> gradientColors;
  final Function() onTap;

  ButtonText({
    Key key,
    @required this.text,
    this.buttonColor,
    this.gradientColors,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [buttonColor, buttonColor] ?? gradientColors,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'GothicBold',
          ),
        ),
      ),
    );
  }
}
