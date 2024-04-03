import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/components/background.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/profile_list_tile.dart';
import 'package:projet_federe/components/text.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/firestore/firestore.dart';
import 'package:projet_federe/services/sncak_bar_services.dart';
import 'package:string_validator/string_validator.dart';
import 'package:svg_flutter/svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //name controller
  TextEditingController nameController = TextEditingController();
  //city controller
  TextEditingController cityController = TextEditingController();
  //phone controller
  TextEditingController phoneController = TextEditingController();
  FireStoreService _fireStoreService = FireStoreService();
  //edit the user infos
  void editUserInfos() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/upload.png",
                      height: 170,
                      width: 170,
                    ),
                  ),
                  const Text("Tap to upload a profile picture"),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(label: 'Name', controller: nameController),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(label: 'city', controller: cityController),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                      label: 'Phone Number', controller: phoneController),
                  const SizedBox(
                    height: 25,
                  ),
                  MainButton(
                      height: 41,
                      width: 150,
                      label: 'Update',
                      onPressed: () {
                        bool test = true;
                        //update infos if you user filled the textfields
                        if (cityController.text != "") {
                          setState(() {
                            _fireStoreService.updateInfos('landlordsProfile',
                                currentUser.uid, cityController.text, 'city');
                          });
                        }
                        if (nameController.text != "") {
                          //check if it is a valid name
                          if (isAlpha(nameController.text)) {
                            _fireStoreService.updateInfos('landlordsProfile',
                                currentUser.uid, nameController.text, 'name');
                            _fireStoreService.updateInfos('user',
                                currentUser.uid, nameController.text, 'name');
                          } else {
                            SnackBarService.showErrorSnackBar(
                                context, "Please Enter a valid name");
                            test = false;
                          }
                        }
                        if (phoneController.text != "") {
                          //check if it is a valid phone number
                          if (isNumeric(phoneController.text) &&
                              phoneController.text.length == 8) {
                            _fireStoreService.updateInfos('phone_number',
                                currentUser.uid, phoneController.text, 'name');
                          } else {
                            SnackBarService.showErrorSnackBar(
                                context, "Please Enter a valid phone Number ");
                            test = false;
                          }
                        }
                        if (test) {
                          SnackBarService.showSuccessSnackBar(
                              context, "Your Infos updated successfully");
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            ));
  }

  User currentUser = FirebaseAuth.instance.currentUser!;
  final CollectionReference _profileReference =
      FirebaseFirestore.instance.collection('landlordsProfile');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Background(
        elements: FutureBuilder(
            future: _fireStoreService
                .getValueFromFirestore(_profileReference.doc(currentUser.uid)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dynamic value = snapshot.data;
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: ClipOval(
                            child: ClipOval(
                                child:
                                    Image.asset('assets/images/profile.png')),
                          ),
                        ),
                        Header(label: value["name"]),
                        rating(value),
                        postedHouses(value),
                        rentedHouses(value),
                        city(value),
                        phoneNumber(value),
                        MainButton(
                            height: 41,
                            width: 165,
                            label: "Edit",
                            onPressed: editUserInfos)
                      ],
                    ),
                  ),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text("Error occured while loading profile data");
                }
              }
            }),
      ),
    );
  }

//phone number section
  Row phoneNumber(value) {
    return Row(
      children: [
        SizedBox(
          width: 270,
          child: ProfileListTile(
            label: "Number :",
            content: Text(
              value["phone_number"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
        value["phone_visibility"] == false
            ? SvgPicture.asset(
                "assets/images/visible.svg",
                height: 35,
                width: 35,
                color: myPrimaryColor,
              )
            : SvgPicture.asset(
                "assets/images/not_visible.svg",
                height: 35,
                width: 35,
                color: myPrimaryColor,
              ),
      ],
    );
  }

//city section
  Row city(value) {
    return Row(
      children: [
        SizedBox(
          width: 270,
          child: ProfileListTile(
            label: "city :",
            content: Text(
              value["city"] == "" ? "Not specified" : value["city"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
        value["city_visiblity"] == false
            ? SvgPicture.asset(
                "assets/images/visible.svg",
                height: 35,
                width: 35,
                color: myPrimaryColor,
              )
            : SvgPicture.asset(
                "assets/images/not_visible.svg",
                height: 35,
                width: 35,
                color: myPrimaryColor,
              ),
      ],
    );
  }

//rented houses section
  ProfileListTile rentedHouses(value) {
    return ProfileListTile(
        label: "Rented Houses :",
        content: Text(
          value["rented_houses"].toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ));
  }

  ProfileListTile rating(value) => rate(value);
//posted houses section
  ProfileListTile postedHouses(value) {
    return ProfileListTile(
        label: "Posted Houses :",
        content: Text(
          value["posted_houses"].toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ));
  }

//rating section
  ProfileListTile rate(value) {
    return ProfileListTile(
        label: "Rating :",
        content: value["rate"] == 0
            ? const Text(
                "not rated yet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              )
            : Text(value["rate"]));
  }
}
