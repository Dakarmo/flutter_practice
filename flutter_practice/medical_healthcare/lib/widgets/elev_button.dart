import 'package:flutter/material.dart';
import 'package:medical_heathcare/utils/utils.dart';

class ElevButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  final Color? color;

  const ElevButton(
      {Key? key,
        required this.text,
        required this.icon,
        required this.onPressed,
        this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color ?? APP_COLOR,),
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 10,),
          Text(text, style: TextStyle(color: Colors.white)),

        ],
      ),
    );
  }
}
