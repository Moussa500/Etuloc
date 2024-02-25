import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_federe/atoms/colors.dart';
import 'package:projet_federe/atoms/device_dimensions.dart';
import 'package:projet_federe/atoms/textfields.dart';
import 'package:projet_federe/providers/textfields_state.dart';
import 'package:provider/provider.dart';

class EtudiantHomePage extends StatelessWidget {
  EtudiantHomePage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TextFieldsState>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello ${user!.displayName}',
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: const [
            Icon(
              Icons.settings,
              color: myPrimaryColor,
              size: 55,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Center(
                  child: CustomTextField(
                    icon: const Icon(Icons.search),
                    label: 'Search',
                    controller: controller.searchController,
                    customwidth: MediaQuery.of(context).size.width * .9,
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              SizedBox(
                width: Dimensions.deviceWidth(context)*.9,
                height: Dimensions.deviceHeight(context) * .6,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Container(
                          height: Dimensions.deviceWidth(context) * .4,
                          decoration: const BoxDecoration(
                            color: mySecondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
