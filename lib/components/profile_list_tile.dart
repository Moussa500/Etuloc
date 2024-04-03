import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String label;
  final Widget content;
  final Widget? trailing;
  const ProfileListTile({super.key,required this.label,required this.content,this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(label,style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),),
      title: content,
      trailing: trailing,
    );
  }
}
