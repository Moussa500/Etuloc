import 'package:flutter/material.dart';
import 'package:projet_federe/atoms/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  TextEditingController controller;
  Icon? icon;
  double? customwidth;
  CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.customwidth,
  }) : super(key: key);
  double? width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      width: customwidth!=null?customwidth:width! * .7,
      decoration: BoxDecoration(
        color: myBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(style: BorderStyle.none),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 6, color: myShadowColor),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 9),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: icon,
              hintText: label,
              hintStyle: const TextStyle(fontSize: 20),
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
    );
  }
}
