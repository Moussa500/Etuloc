import 'package:flutter/material.dart';

class CheckBoxChanger extends ChangeNotifier {
  bool value = false;
  void changeCheckBoxValue(bool newValue) {
    if (value == false) {
      newValue = true;
    } else {
      newValue = false;
    }
    value = newValue;
    notifyListeners();
  }
}