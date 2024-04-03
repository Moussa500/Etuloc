import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/components/background.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/text.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/pages/login_page.dart';
import 'package:projet_federe/services/auth/auth_service.dart';
import 'package:projet_federe/services/sncak_bar_services.dart';
import 'package:projet_federe/stateManagement/checkbox.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  void register(BuildContext context, String status) {
    final authService = AuthService();
    //try register
    try {
      authService.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
          _phoneNumberController.text,
          status);
      SnackBarService.showSuccessSnackBar(
          context, "Congratulations! you're account has successfully created");
    } on FirebaseAuthException catch (e) {
      SnackBarService.showErrorSnackBar(context, e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    var checkBoxChanger = Provider.of<CheckBoxChanger>(context);
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Background(
                elements: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonSlider(
                      loginTap: onTap,
                      registerTap: () {},
                      mainButtonColor: myBackgroundColor,
                      sideButtonColor: mySecondaryColor,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 56, top: 20, bottom: 30),
                      child: Column(
                        children: [
                          Header(
                            label: 'Hello there,',
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CustomTextField(
                            label: 'email', controller: _emailController),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          label: "password",
                          controller: _passwordController,
                          obscured: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          label: 'Name',
                          controller: _nameController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          label: 'Phone Number',
                          controller: _phoneNumberController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Are you a student ?',
                              style: TextStyle(
                                color: myLabelColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Checkbox(
                              value: checkBoxChanger.value,
                              onChanged: (value) {
                                checkBoxChanger.changeCheckBoxValue(value!);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MainButton(
                          height: 70,
                          width: Dimensions.deviceWidth(context) * .6,
                          label: 'Sign Up',
                          onPressed: () {
                            String status;
                            checkBoxChanger.value == true
                                ? status = "student"
                                : status = "landlord";
                            register(context,status);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
