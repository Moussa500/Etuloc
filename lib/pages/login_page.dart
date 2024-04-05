// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:projet_federe/components/background.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/text.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/services/auth/auth_service.dart';
import 'package:projet_federe/services/sncak_bar_services.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();
    //try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      SnackBarService.showSuccessSnackBar(context, "Welcomes");
    } catch (e) {
      SnackBarService.showErrorSnackBar(context, e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    loginTap: () {},
                    registerTap: onTap,
                    mainButtonColor: mySecondaryColor,
                    sideButtonColor: myBackgroundColor,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 56, top: 50, bottom: 60),
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
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextField(
                        label: "password",
                        controller: _passwordController,
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
                          width: Dimensions.deviceWidth(context) * .6,
                          label: 'Login',
                          onPressed: () {
                            login(context);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonSlider extends StatelessWidget {
  final void Function()? loginTap;
  final void Function()? registerTap;
  final Color mainButtonColor;
  final Color sideButtonColor;
  const ButtonSlider(
      {super.key,
      required this.loginTap,
      required this.registerTap,
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
            onPressed: loginTap,
            buttonColor: mainButtonColor,
          ),
          LogRegButton(
            label: 'Sign Up',
            onPressed: registerTap,
            buttonColor: sideButtonColor,
          ),
        ],
      ),
    );
  }
}
