import 'package:flutter/material.dart';

class TextFieldsState extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController registerEmailcontroller = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  void disposeControllers() {
    emailController.dispose();
    locationController.dispose();
    passwordController.dispose();
    registerEmailcontroller.dispose();
    registerPasswordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
  }
}
