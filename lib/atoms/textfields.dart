import 'package:flutter/material.dart';
import 'package:projet_federe/atoms/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  TextEditingController controller;
  bool? obscured;
  Icon? icon;
  double? customwidth;
  void Function(String)? onChanged;
  CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.customwidth,
    this.onChanged,
    this.obscured,
  }) : super(key: key);
  double? width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      width: customwidth != null ? customwidth : width! * .7,
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
            textDirection: TextDirection.ltr,
            controller: controller,
            onChanged: onChanged,
            obscureText: obscured==null?false:true,
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
