import 'package:flutter/material.dart';

class ButtonDialog extends StatelessWidget {
  const ButtonDialog({
    Key key,
    this.fontColor = Colors.grey,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);
  final Color fontColor;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        label,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
