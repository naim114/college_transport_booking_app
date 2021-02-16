import 'package:flutter/material.dart';

class ButtonBackTop extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final Color color;

  const ButtonBackTop({
    Key key,
    this.onTap,
    this.child,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.of(context).pop();
          },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: color),
            ),
            child ??
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
