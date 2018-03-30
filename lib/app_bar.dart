import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    Key key,
    this.text,
    this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      child: new Text(
        text,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
