import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_federe/components/background.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/profile_list_tile.dart';
import 'package:projet_federe/components/text.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/firebase_storage.dart/firebase_storage.dart';
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
  final StorageService _storageService = StorageService();
  String? imagePath;
  File? imageFile;
  //name controller
  TextEditingController nameController = TextEditingController();
  //city controller
  TextEditingController cityController = TextEditingController();
  //phone controller
  TextEditingController phoneController = TextEditingController();
  final FireStoreService _fireStoreService = FireStoreService();
  // Boolean variables that can potentially be null
  bool cityVisibility = false; // Initialized as false by default
  bool phoneVisibility = false; // Initialized as false by default
  User currentUser = FirebaseAuth.instance.currentUser!;
  final CollectionReference _profileReference =
      FirebaseFirestore.instance.collection('landlordsProfile');

  //edit the user infos
  void editUserInfos() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          imageFile = File(image.path);
                          SnackBarService.showSuccessSnackBar(context,
                              "Your image has been uploaded successfully");
                        } else {
                          SnackBarService.showErrorSnackBar(context,
                              "Error occurred while uploading your image");
                        }
                      },
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
                        onPressed: () async {
                          bool test = true;
                          //update infos if the user filled the textfields
                          if (cityController.text.isNotEmpty) {
                            setState(() {
                              _fireStoreService.updateInfos('landlordsProfile',
                                  currentUser.uid, cityController.text, 'city');
                            });
                          }
                          if (nameController.text.isNotEmpty) {
                            //check if it is a valid name
                            if (isAlpha(nameController.text)) {
                              setState(() {
                                _fireStoreService.updateInfos(
                                    'landlordsProfile',
                                    currentUser.uid,
                                    nameController.text,
                                    'name');
                              });
                              _fireStoreService.updateInfos('user',
                                  currentUser.uid, nameController.text, 'name');
                            } else {
                              SnackBarService.showErrorSnackBar(
                                  context, "Please Enter a valid name");
                              test = false;
                            }
                          }
                          if (phoneController.text.isNotEmpty) {
                            //check if it is a valid phone number
                            if (isNumeric(phoneController.text) &&
                                phoneController.text.length == 8) {
                              setState(() {
                                _fireStoreService.updateInfos(
                                    'landlordsProfile',
                                    currentUser.uid,
                                    phoneController.text,
                                    'phone_number');
                                _fireStoreService.updateInfos(
                                    'user',
                                    currentUser.uid,
                                    phoneController.text,
                                    'phone_number');
                              });
                            } else {
                              SnackBarService.showErrorSnackBar(context,
                                  "Please Enter a valid phone Number ");
                              test = false;
                            }
                          }
                          if (imageFile != null) {
                            String downloadUrl = await _storageService
                                .uploadImage('images',imageFile!.path);
                            _fireStoreService.updateInfos(
                                'landlordsProfile',
                                currentUser.uid,
                                downloadUrl.toString(),
                                'pdp');
                            setState(() {
                              imagePath = downloadUrl.toString();
                            });
                          }
                          if (test) {
                            SnackBarService.showSuccessSnackBar(
                                context, "Your Infos updated successfully");
                            Navigator.pop(context);
                          }
                        })
                  ],
                ),
              ),
            ));
  }

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
                value["pdp"] == ""
                    ? imagePath = "assets/images/profile.png"
                    : imagePath = value["pdp"];
                cityVisibility = value["city_visibility"] ?? false;
                phoneVisibility = value["phone_visibility"] ?? false;
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: ClipOval(
                              child: snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? CircularProgressIndicator()
                                  : value["pdp"] == ""
                                      ? Image.asset(
                                          imagePath!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          imagePath!,
                                          fit: BoxFit.cover,
                                        )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Header(label: value["name"]),
                        const SizedBox(
                          height: 10,
                        ),
                        rating(value),
                        const SizedBox(
                          height: 10,
                        ),
                        postedHouses(value),
                        const SizedBox(
                          height: 10,
                        ),
                        rentedHouses(value),
                        const SizedBox(
                          height: 10,
                        ),
                        city(value, cityVisibility),
                        const SizedBox(
                          height: 10,
                        ),
                        phoneNumber(value, phoneVisibility),
                        const SizedBox(
                          height: 10,
                        ),
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
                  return const Text("Error occurred while loading profile data");
                }
              }
            }),
      ),
    );
  }

  //phone number section
  Row phoneNumber(value, bool phoneVisibility) {
    return Row(
      children: [
        SizedBox(
          width: 270,
          child: ProfileListTile(
            label: "Number :",
            content: Text(
              value["phone_number"] ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              phoneVisibility = !phoneVisibility;
            });
            await _fireStoreService.updateInfos("landlordsProfile",
                currentUser.uid, phoneVisibility, "phone_visibility");
          },
          child: SvgPicture.asset(
            phoneVisibility ? "assets/images/visible.svg" : "assets/images/not_visible.svg",
            height: 35,
            width: 35,
            color: myPrimaryColor,
          ),
        ),
      ],
    );
  }

  //city section
  Row city(value, bool cityVisibility) {
    return Row(
      children: [
        SizedBox(
          width: 270,
          child: ProfileListTile(
            label: "city :",
            content: Text(
              value["city"] == "" ? "Not specified" : value["city"] ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              cityVisibility = !cityVisibility;
            });
            await _fireStoreService.updateInfos("landlordsProfile",
                currentUser.uid, cityVisibility, "city_visibility");
          },
          child: SvgPicture.asset(
            cityVisibility ? "assets/images/visible.svg" : "assets/images/not_visible.svg",
            height: 35,
            width: 35,
            color: myPrimaryColor,
          ),
        ),
      ],
    );
  }

  //rented houses section
  ProfileListTile rentedHouses(value) {
    return ProfileListTile(
        label: "Rented Houses :",
        content: Text(
          value["rented_houses"]?.toString() ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ));
  }

  //posted houses section
  ProfileListTile postedHouses(value) {
    return ProfileListTile(
        label: "Posted Houses :",
        content: Text(
          value["posted_houses"]?.toString() ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ));
  }

  //rating section
  ProfileListTile rating(value) {
int? avg;
if (value["number_ratings"] != null && value["number_ratings"] != 0) {
  avg = value["sum_ratings"]! ~/ value["number_ratings"]!;
} else {
  print("not rated yet");
}
    return ProfileListTile(
      label: "Rating :",
      content: value["number_ratings"] == 0
          ? const Text(
              "not rated yet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            )
          : SizedBox(
              width: 50,
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: avg,
                  itemBuilder: (context, index) {
                    return SvgPicture.asset(
                      "assets/images/star.svg",
                      height: 25,
                      width: 25,
                    );
                  })),
    );
  }
}
