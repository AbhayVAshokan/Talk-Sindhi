// Design for submit buttons in login and register screens.

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final double width;
  final Color color;
  final Function onTap;

  SubmitButton({
    @required this.text,
    @required this.onTap,
    this.width = 100.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              fontSize: 15.0,
            ),
          ),
        ),
        color: color,
        onPressed: () => onTap(),
      ),
    );
  }
}
