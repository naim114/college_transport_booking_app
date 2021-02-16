import 'package:flutter/material.dart';

class ButtonRoundedCornerIcon extends StatelessWidget {
  const ButtonRoundedCornerIcon({
    Key key,
    @required this.label,
    this.style,
    @required this.buttonColor,
    @required this.borderColor,
    this.borderRadius = 18,
    @required this.onPressed,
    this.insidePadding = 5,
    this.borderWidth = 0,
    @required this.icon,
  }) : super(key: key);
  final String label;
  final TextStyle style;
  final Color buttonColor, borderColor;
  final double borderRadius, insidePadding, borderWidth;
  final Function onPressed;
  final Icon icon;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              label,
              style: style ?? defaultTextstyle,
            ),
          ],
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
    // child: Padding(
    //   padding: EdgeInsets.all(insidePadding),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       icon,
    //       SizedBox(width: 10),
    //       Text(
    //         label,
    //         style: style ?? defaultTextstyle,
    //       ),
    //     ],
    //   ),
    // ),
    // );
  }
}
