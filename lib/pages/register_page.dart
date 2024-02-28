import 'package:flutter/material.dart';
import 'package:projet_federe/atoms/buttons.dart';
import 'package:projet_federe/atoms/text.dart';
import 'package:projet_federe/atoms/textfields.dart';
import 'package:projet_federe/atoms/colors.dart';
import 'package:projet_federe/pages/login_page.dart';
import 'package:projet_federe/stateManagement/authprovider.dart';
import 'package:projet_federe/stateManagement/checkbox.dart';
import 'package:projet_federe/stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  double? deviceheight;
  double? devicewidh;
  @override
  Widget build(BuildContext context) {
    deviceheight = MediaQuery.of(context).size.height;
    devicewidh = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: BackgroundContainer(
                deviceheight: deviceheight,
                devicewidh: devicewidh,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  BackgroundContainer({
    super.key,
    required this.deviceheight,
    required this.devicewidh,
  });
  final double? deviceheight;
  final double? devicewidh;
  @override
  Widget build(BuildContext context) {
    var checkBoxChanger = Provider.of<CheckBoxChanger>(context);
    var textFieldsState = Provider.of<TextFieldsState>(context);
    var authentication = Provider.of<AuthProvider>(context);
    return Container(
      height: deviceheight! * .9,
      width: devicewidh! * 0.87,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          ButtonSlider(
            mainButtonColor: myBackgroundColor,
            sideButtonColor: mySecondaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 56, top: 20, bottom: 30),
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
                label: 'email',
                controller: textFieldsState.registerEmailcontroller,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                label: "password",
                controller: textFieldsState.registerPasswordController,
                obscured: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                label: 'Name',
                controller: textFieldsState.nameController,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                label: 'Phone Number',
                controller: textFieldsState.phoneNumberController,
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
                width: devicewidh! * .6,
                label: 'Sign Up',
                onPressed: () {
                  authentication.registerWithEmailandPassword(
                    textFieldsState.registerEmailcontroller.text,
                    textFieldsState.registerPasswordController.text,
                    textFieldsState.nameController.text,
                    textFieldsState.phoneNumberController.text,
                    checkBoxChanger.value == true ? 'Etudiant' : 'landlord',
                    context,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
