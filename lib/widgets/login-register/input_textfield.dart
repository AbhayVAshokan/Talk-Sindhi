// Individual textfields inside the login/register screens.

import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction textInputAction;

  InputTextField({
    @required this.labelText,
    @required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  });

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        style:
            Theme.of(context).textTheme.subtitle1.copyWith(letterSpacing: 0.75),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            letterSpacing: 0.75,
          ),
          errorText: widget.controller.text == '' ? 'Value Can\'t Be Empty' : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
          )),
        ),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
