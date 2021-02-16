import 'package:flutter/material.dart';

class TextfieldTitle extends StatelessWidget {
  final String title;
  final bool isPassword;
  final Color titleColor;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const TextfieldTitle({
    Key key,
    @required this.title,
    this.isPassword = false,
    this.titleColor = Colors.black,
    this.keyboardType = TextInputType.text,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'OpenSansBold',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: titleColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: isPassword,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(5.0),
                ),
              ),
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }
}
