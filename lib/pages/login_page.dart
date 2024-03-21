import 'package:flutter/material.dart';
import 'package:projet_federe/pieces/buttons.dart';
import 'package:projet_federe/pieces/device_dimensions.dart';
import 'package:projet_federe/pieces/text.dart';
import 'package:projet_federe/pieces/textfields.dart';
import 'package:projet_federe/pieces/colors.dart';
import 'package:projet_federe/stateManagement/authprovider.dart';
import 'package:projet_federe/stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BackgroundContainer(
              deviceheight: Dimensions.deviceHeight(context),
              devicewidh: Dimensions.deviceWidth(context),
            ),
          ),
        ),
      ),
    );
  }
}
class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    super.key,
    required this.deviceheight,
    required this.devicewidh,
  });
  final double? deviceheight;
  final double? devicewidh;
  @override
  Widget build(BuildContext context) {
    var textFieldsState = Provider.of<TextFieldsState>(context);
    var authentication = Provider.of<AuthProvider>(context);
    return Container(
      height: deviceheight! * .87,
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
            mainButtonColor: mySecondaryColor,
            sideButtonColor: myBackgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 56, top: 50, bottom: 60),
            child: Column(
              children: [
                Header(
                  label: 'Welcome back,',
                ),
                const Text(
                  'Happy to see you again',
                  style: TextStyle(
                    color: myLabelColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomTextField(
                label: 'email',
                controller: textFieldsState.emailController,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                label: "password",
                controller: textFieldsState.passwordController,
                obscured: true,
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 95),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "reset");
                  },
                  child: const Text(
                    'Forget Password ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: myLabelColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MainButton(
                  height: 70,
                  width: devicewidh! * .6,
                  label: 'Login',
                  onPressed: () {
                    authentication.loginWithEmailandPassword(
                        textFieldsState.emailController.text,
                        textFieldsState.passwordController.text,
                        context);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
class ButtonSlider extends StatelessWidget {
  Color mainButtonColor;
  Color sideButtonColor;
  ButtonSlider(
      {super.key,
      required this.mainButtonColor,
      required this.sideButtonColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      height: 95,
      decoration: const BoxDecoration(
        color: mySecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(23)),
      ),
      child: Row(
        children: [
          LogRegButton(
            label: 'Sign in',
            onPressed: () {
              Navigator.pushNamed(context, "login");
            },
            buttonColor: mainButtonColor,
          ),
          LogRegButton(
            label: 'Sign Up',
            onPressed: () {
              Navigator.pushNamed(context, "register");
            },
            buttonColor: sideButtonColor,
          ),
        ],
      ),
    );
  }
}
