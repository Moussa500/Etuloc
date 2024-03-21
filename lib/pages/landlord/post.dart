import 'package:flutter/material.dart';
import 'package:projet_federe/pieces/background.dart';
import 'package:projet_federe/pieces/colors.dart';
import 'package:projet_federe/pieces/device_dimensions.dart';
import 'package:projet_federe/pieces/text.dart';
import '../../stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';
class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Provider.of<TextFieldsState>(context);
    return  Scaffold(
      body: Background(elements: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: 
      [
        Header(label: "Post a House"),
        PostTextField(label:'', controller:controller.locationController)
      ],),),
    );
  }
}

class PostTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool? obscured;
  final Icon? icon;
  final double? customwidth;
  final void Function(String)? onChanged;
  const PostTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.customwidth,
    this.onChanged,
    this.obscured,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: customwidth != null ? customwidth : Dimensions.deviceWidth(context)! * .7,
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
              suffix: DropdownMenu(dropdownMenuEntries: [DropdownMenuEntry(value: Text('value'), label: 'Location')
              ],),
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
