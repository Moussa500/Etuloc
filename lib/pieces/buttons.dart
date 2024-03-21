import 'package:flutter/material.dart';
import 'package:projet_federe/pieces/colors.dart';
class LogRegButton extends StatelessWidget {
  Color buttonColor;
  void Function() onPressed;
  String label;
  LogRegButton(
      {super.key,
      required this.buttonColor,
      required this.label,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 79,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  color: myShadowColor.withOpacity(0.3),
                )
              ]),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: myTitlesColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class MainButton extends StatelessWidget {
  double height;
  double width;
  String label;
  Color? buttonColor;
  Color? textColor;
  void Function() onPressed;
  MainButton(
      {super.key,
      required this.height,
      this.buttonColor,
      required this.width,
      required this.label,
      this.textColor,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: buttonColor == null ? myPrimaryColor : buttonColor,
        ),
        child: Center(
          child: Text(
            label,
            style:  TextStyle(
              color: textColor == null ? myBackgroundColor : textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
