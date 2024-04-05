import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final void Function()? ontap;
  final String label;
  final IconData icon;
  const ItemListTile({super.key,required this.label,required this.icon,required this.ontap});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(label,style: const TextStyle(
          color: Colors.white,
        ),),
      ),
    );
  }
}
