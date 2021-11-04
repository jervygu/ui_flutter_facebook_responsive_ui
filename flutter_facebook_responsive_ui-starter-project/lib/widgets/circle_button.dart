import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  // const CircleButton({Key? key}) : super(key: key);
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const CircleButton(
      {Key key,
      @required this.icon,
      @required this.iconSize,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.black,
      ),
    );
  }
}
