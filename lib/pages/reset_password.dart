import 'package:flutter/material.dart';
import 'package:projet_federe/pieces/buttons.dart';
import 'package:projet_federe/pieces/text.dart';
import 'package:projet_federe/pieces/textfields.dart';
import 'package:projet_federe/pages/Etudiant/houseperhousedetails.dart';
import 'package:projet_federe/stateManagement/authprovider.dart';
import 'package:projet_federe/stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';

class resetPassword extends StatelessWidget {
  const resetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var controller = Provider.of<TextFieldsState>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Header(label: "Recover Password"),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 26),
              child: Text(
                "Enter the Email Adresse associated with your account",
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            CustomTextField(
              label: "Email",
              controller: controller.emailController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: MainButton(
                  height: 55,
                  width: 221,
                  label: "Recover Password",
                  onPressed: () {
                    authProvider.resetPassword(
                        controller.emailController.text, context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
