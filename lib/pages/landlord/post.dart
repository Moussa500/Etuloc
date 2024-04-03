import 'package:flutter/material.dart';
import 'package:projet_federe/components/background.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/text.dart';
import 'package:projet_federe/services/auth/auth_service.dart';
import '../../stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';

class Post extends StatelessWidget {
  Post({super.key});
  final TextEditingController locationController = TextEditingController();
  //logout function
  void logout() async {
    final authService = AuthService();
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  logout();
                },
                child: const Icon(Icons.logout)),
          )
        ],
      ),
      body: Background(
        elements: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Header(label: "Post a House"),
            PostTextField(label: '', controller: locationController)
          ],
        ),
      ),
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
      width: customwidth != null
          ? customwidth
          : Dimensions.deviceWidth(context) * .7,
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
            obscureText: obscured == null ? false : true,
            decoration: InputDecoration(
              suffix: DropdownMenu(
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: Text('value'), label: 'Location')
                ],
              ),
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
