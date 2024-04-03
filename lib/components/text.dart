import 'package:flutter/material.dart';
import 'package:projet_federe/components/colors.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  String label;
  Header({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          color: myTitlesColor, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }
}
