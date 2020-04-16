// Individual textfields inside the login/register screens.
import 'package:flutter/material.dart';

Widget inputTextFormField({
  @required BuildContext context,
  @required String labelText,
  @required var data,
  @required Function validation,
  Function onChanged,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  TextInputAction textInputAction = TextInputAction.next,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: TextFormField(
      style:
          Theme.of(context).textTheme.subtitle1.copyWith(letterSpacing: 0.75),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: const Color.fromRGBO(156, 9, 9, 0.4),
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
          letterSpacing: 0.75,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
      ),
      validator: validation,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
    ),
  );
}
