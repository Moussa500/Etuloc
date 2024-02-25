import 'package:flutter/material.dart';

class SnackBarService {
  static void showErrorSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
    ));
  }
  static void showSuccessSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content),backgroundColor: Colors.green,));
  }
}
