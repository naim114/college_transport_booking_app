import 'package:flutter/material.dart';

class ButtonIconRoundedCorner extends StatelessWidget {
  const ButtonIconRoundedCorner({
    Key key,
    @required this.icon,
    @required this.onTap,
    this.borderColor,
    this.buttonColor,
  }) : super(key: key);

  final Icon icon;
  final Function() onTap;
  final Color borderColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.5),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Theme.of(context).primaryColor,
              width: 4.0,
            ),
            color: buttonColor ?? Colors.indigo[900],
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(1000.0),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
