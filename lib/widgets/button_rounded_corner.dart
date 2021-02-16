import 'package:flutter/material.dart';

class ButtonRoundedCorner extends StatelessWidget {
  const ButtonRoundedCorner({
    Key key,
    @required this.label,
    this.style,
    @required this.buttonColor,
    @required this.borderColor,
    this.borderRadius = 18,
    @required this.onPressed,
    this.insidePadding = 5,
    this.borderWidth = 0,
  }) : super(key: key);
  final String label;
  final TextStyle style;
  final Color buttonColor, borderColor;
  final double borderRadius, insidePadding, borderWidth;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextstyle = TextStyle(
      // fontWeight: FontWeight.bold,
      fontFamily: 'GothicA1Bold',
      color: Colors.white,
    );

    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(insidePadding),
        child: Text(
          label,
          style: style ?? defaultTextstyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
    // return FlatButton(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(borderRadius),
    //     side: BorderSide(
    //       color: borderColor,
    //       width: borderWidth,
    //     ),
    //   ),
    //   color: buttonColor,
    //   onPressed: onPressed,
    //   child: Padding(
    //     padding: EdgeInsets.all(insidePadding),
    //     child: Text(
    //       label,
    //       style: style ?? defaultTextstyle,
    //     ),
    //   ),
    // );
  }
}
