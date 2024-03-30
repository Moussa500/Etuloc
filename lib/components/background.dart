import 'package:flutter/material.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';

class Background extends StatelessWidget {
  final Widget elements;
  const Background({
    required this.elements,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.deviceHeight(context)* .87,
        width: Dimensions.deviceWidth(context)* 0.87,
        decoration: const BoxDecoration(
          color: myBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(35)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 6,
              color: myShadowColor,
            ),
          ],
        ),
        child:elements
      ),
    );
  }
}