import 'package:college_transport_booking_app/services/database_helper.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key key,
    @required this.labelText,
    @required this.initialValue,
  }) : super(key: key);

  final String labelText, initialValue;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode _focusNode = FocusNode();
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      print('lost focus!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      initialValue: widget.initialValue,
      focusNode: _focusNode,
    );
  }
}
