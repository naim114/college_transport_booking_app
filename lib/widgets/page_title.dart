import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    @required this.title,
    @required this.description,
    @required this.titleFontSize,
    @required this.descriptionFontSize,
    Key key,
    this.descriptionColor = Colors.black,
    this.titleColor = Colors.black,
  }) : super(key: key);
  final String title;
  final String description;
  final double titleFontSize, descriptionFontSize;
  final Color descriptionColor, titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 10,
            style: TextStyle(
              fontSize: titleFontSize,
              color: titleColor,
              fontFamily: "OpenSansBold",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 0.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: descriptionFontSize,
                // color: Color.fromRGBO(51, 51, 51, 1.0),
                color: descriptionColor,
                fontFamily: "GothicA1",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
