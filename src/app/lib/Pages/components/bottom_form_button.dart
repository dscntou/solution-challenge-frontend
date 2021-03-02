import 'package:flutter/material.dart';

class RectengleButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function press;
  const RectengleButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
      child: Text(text),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        shape: ContinuousRectangleBorder(),
        primary: color,
        minimumSize: Size.fromHeight(50.0),
      ),
    ));
  }
}
