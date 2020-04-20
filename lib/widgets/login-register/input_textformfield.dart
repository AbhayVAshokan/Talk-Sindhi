// Individual textfields inside the login/register screens.
import 'package:flutter/material.dart';

Widget inputTextFormField({
  @required BuildContext context,
  @required String labelText,
  @required var data,
  @required Function validation,
  Function onChanged,
  IconData prefixIcon,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  bool obscureText = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: TextFormField(
      style:
          Theme.of(context).textTheme.subtitle1.copyWith(letterSpacing: 0.75),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).primaryColor,
                size: 28.0,
              )
            : null,
        labelText: labelText,
        labelStyle: TextStyle(
          color: const Color.fromRGBO(156, 9, 9, 0.4),
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
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
