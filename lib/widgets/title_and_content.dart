import 'package:flutter/material.dart';

class TitleAndContent extends StatelessWidget {
  const TitleAndContent({
    Key key,
    @required this.title,
    @required this.content,
    this.titleFontSize = 20,
    this.contentFontSize = 24,
    this.verticalSpacing = 3,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.titleFontColor = Colors.white,
    this.contentFontColor = Colors.white,
  }) : super(key: key);
  final String title, content;
  final double titleFontSize,
      contentFontSize,
      verticalSpacing,
      paddingTop,
      paddingBottom,
      paddingLeft,
      paddingRight;
  final Color titleFontColor, contentFontColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleFontColor,
              fontFamily: 'OpenSansBold',
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(
            height: verticalSpacing,
          ),
          Text(
            content,
            style: TextStyle(
              color: contentFontColor,
              fontSize: contentFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
