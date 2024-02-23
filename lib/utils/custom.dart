
import 'package:flutter/material.dart';

class DiceButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  final TextStyle textStyle;
  final Color buttonColor;

  const DiceButton(
      {super.key,
        required this.label,
        required this.onPressed,
        required this.buttonColor,
        required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
          child: Text(
            label,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}