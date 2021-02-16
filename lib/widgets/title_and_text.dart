import 'package:flutter/material.dart';

class TitleAndText extends StatelessWidget {
  final String title, text;
  final Color titleColor, textColor;

  const TitleAndText({
    Key key,
    @required this.title,
    @required this.text,
    this.titleColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'GothicA1Bold',
            color: titleColor ?? Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 2),
        Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: textColor ?? Colors.black,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
