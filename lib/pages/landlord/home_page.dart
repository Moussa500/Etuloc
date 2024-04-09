// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/landlord_card.dart';
import 'package:projet_federe/components/my_drawer.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/firebase_storage.dart/firebase_storage.dart';
import 'package:projet_federe/services/firestore/firestore.dart';
import 'package:projet_federe/services/location/location_service.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

class LandLordHomePage extends StatefulWidget {
  const LandLordHomePage({super.key});
  @override
  State<LandLordHomePage> createState() => _LandLordHomePageState();
}

class _LandLordHomePageState extends State<LandLordHomePage> {
  final StorageService _storageService = StorageService();
  final FireStoreService _fireStoreService = FireStoreService();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController rentTypeController = TextEditingController();
  TextEditingController moreInfoController = TextEditingController();
  TextEditingController placesNumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  double? lat;
  double? long;
  List<XFile> images = [];
  //get current location
  LocationService location = LocationService();
  Widget? places;

  bool checkUserInput() {
    bool test = true;
    if (images.isEmpty) {
      errorDialog(context, "Images are required");
      test = false;
    } else if (priceController.text.isEmpty) {
      errorDialog(context, "The price is required");
      test = false;
    } else if (locationController.text.isEmpty) {
      errorDialog(context, "Location is required");
      test = false;
    } else {
      if (typeController.text.isEmpty) {
        errorDialog(context, "type is required");
        test = false;
      } else {
        if (genderController.text.isEmpty) {
          errorDialog(context, "Gender is required");
          test = false;
        } else {
          if (rentTypeController.text.isEmpty) {
            errorDialog(context, "Renting Type is required");
            test = false;
          } else {
            if (placesNumberController.text.isEmpty &&
                rentTypeController.text == "Bed") {
              errorDialog(context,
                  "you should specify the number of places if you went to rent per bed");
              test = false;
            }
          }
        }
      }
    }
    return test;
  }

  void postHouse() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 170,
                        width: 170,
                        child: GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              images = await picker.pickMultiImage();
                            },
                            child: Image.asset("assets/images/upload.png"))),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      label: "Price",
                      controller: priceController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    locationSection(context),
                    const SizedBox(
                      height: 25,
                    ),
                    typeSection(context),
                    const SizedBox(
                      height: 25,
                    ),
                    genderSection(context),
                    const SizedBox(
                      height: 25,
                    ),
                    rentingTypeSection(context),
                    const SizedBox(
                      height: 25,
                    ),
                    placesNumberSection(context),
                    const SizedBox(
                      height: 25,
                    ),
                    moreInfosSection(),
                    const SizedBox(
                      height: 25,
                    ),
                    postButton(context)
                  ],
                ),
              ),
            ));
  }

  MainButton postButton(BuildContext context) {
    return MainButton(
        height: 70,
        width: 120,
        label: "Post",
        onPressed: () async {
          if (checkUserInput()) {
            String cityName =
                await location.getCityNameFromCoordinates(lat!, long!);
            String imagesUrl =
                await _storageService.uploadMultipleImages(images, "house");
            await _fireStoreService.postHouse(
                cityName,
                priceController.text,
                imagesUrl,
                placesNumberController.text,
                locationController.text,
                rentTypeController.text == "Bed" ? true : false,
                typeController.text,
                rentTypeController.text == "Bed"
                    ? placesNumberController.text
                    : "0",
                currentUser!.uid,
                genderController.text);
            Navigator.pop(context);
            successDialog(
                // ignore: use_build_context_synchronously
                context,
                "You're house posted successfully");
          }
        });
  }

  CustomTextField moreInfosSection() {
    return CustomTextField(
        label: "type more infos ", controller: moreInfoController);
  }

  Container placesNumberSection(BuildContext context) {
    return Container(
      width: Dimensions.deviceWidth(context) * .7,
      decoration: BoxDecoration(
        color: myBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(style: BorderStyle.none),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 6, color: myShadowColor),
        ],
      ),
      child: DropdownMenu(
          controller: placesNumberController,
          enableSearch: true,
          hintText: "Number of places",
          width: Dimensions.deviceWidth(context) * .65,
          menuHeight: 100,
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          dropdownMenuEntries: const <DropdownMenuEntry>[
            DropdownMenuEntry(value: 1, label: "1"),
            DropdownMenuEntry(value: 2, label: "2"),
            DropdownMenuEntry(value: 3, label: "3"),
            DropdownMenuEntry(value: 4, label: "4"),
          ]),
    );
  }

  Container rentingTypeSection(BuildContext context) {
    return Container(
      width: Dimensions.deviceWidth(context) * .7,
      decoration: BoxDecoration(
        color: myBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(style: BorderStyle.none),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 6, color: myShadowColor),
        ],
      ),
      child: DropdownMenu(
          controller: rentTypeController,
          enableSearch: true,
          hintText: "Renting Type",
          width: Dimensions.deviceWidth(context) * .65,
          menuHeight: 100,
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          dropdownMenuEntries: const <DropdownMenuEntry>[
            DropdownMenuEntry(value: "House", label: "House"),
            DropdownMenuEntry(value: "Bed", label: "Bed"),
          ]),
    );
  }

  Container genderSection(BuildContext context) {
    return Container(
      width: Dimensions.deviceWidth(context) * .7,
      decoration: BoxDecoration(
        color: myBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(style: BorderStyle.none),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 6, color: myShadowColor),
        ],
      ),
      child: DropdownMenu(
          controller: genderController,
          enableSearch: true,
          hintText: "Gender",
          width: Dimensions.deviceWidth(context) * .65,
          menuHeight: 100,
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          dropdownMenuEntries: const <DropdownMenuEntry>[
            DropdownMenuEntry(value: "Female", label: "Female"),
            DropdownMenuEntry(value: "Male", label: "Male"),
          ]),
    );
  }

  Container typeSection(BuildContext context) {
    return Container(
      width: Dimensions.deviceWidth(context) * .7,
      decoration: BoxDecoration(
        color: myBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(style: BorderStyle.none),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 6, color: myShadowColor),
        ],
      ),
      child: DropdownMenu(
          controller: typeController,
          enableSearch: true,
          hintText: "Type",
          width: Dimensions.deviceWidth(context) * .65,
          menuHeight: 100,
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          dropdownMenuEntries: const <DropdownMenuEntry>[
            DropdownMenuEntry(value: "s+1", label: "s+1"),
            DropdownMenuEntry(value: "s+2", label: "s+2"),
            DropdownMenuEntry(value: "s+3", label: "s+3"),
          ]),
    );
  }

  Row locationSection(BuildContext context) {
    return Row(
      children: [
        CustomTextField(
          label: "Location",
          controller: locationController,
          customwidth: Dimensions.deviceWidth(context) * .5,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            location.getCurrentLocation().then((value) {
              lat = value.latitude;
              long = value.longitude;
              location.decodeCoordinates(lat!, long!).then((value) {
                setState(() {
                  locationController.text = value.toString();
                });
              });
            });
          },
          child: SvgPicture.asset(
            "assets/images/map.svg",
            height: 40,
            width: 40,
            // ignore: deprecated_member_use
            color: myPrimaryColor,
          ),
        ),
      ],
    );
  }

  Future<dynamic> errorDialog(BuildContext context, String error) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                error,
                style: const TextStyle(color: Colors.white),
              ),
            ));
  }

  Future<dynamic> successDialog(BuildContext context, String content) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.green,
              content: Text(
                content,
                style: TextStyle(color: Colors.white),
              ),
            ));
  }

  final FireStoreService fireStoreService = FireStoreService();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeState>(context);
    var searchTextProvider = Provider.of<SearchTextProvider>(context);
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => postHouse(),
        backgroundColor: myPrimaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: Text(
          'Hello ${currentUser!.displayName}',
          style: const TextStyle(
            fontFamily: "poppins",
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                  controller: TextEditingController(
                      text: searchTextProvider.searchText),
                  onChanged: (text) {
                    searchTextProvider.searchText = text;
                  },
                  customwidth: MediaQuery.of(context).size.width * .9,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _fireStoreService.getHousedStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.docs;
                        return FutureBuilder(
                            future: _fireStoreService.getValueFromFirestore(
                                FirebaseFirestore.instance
                                    .collection("houses")
                                    .doc()),
                            builder: (context, snapshot) {
                              return Center(
                                child: Container(
                                  width: Dimensions.deviceWidth(context),
                                  height: Dimensions.deviceHeight(context) * .7,
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        if (data[index]["uid"] ==
                                            currentUser!.uid) {
                                          List<String> pathList = data[index]
                                                  ["images_url"]
                                              .split(',');
                                          return LandLordCard(
                                            ontap: () async {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            content: const Text(
                                                              "Are you sure ?",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "poppins",
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            actions: [
                                                              MainButton(
                                                                  height: 50,
                                                                  width: 75,
                                                                  label: "Yes",
                                                                  onPressed:
                                                                      () async {
                                                                    await _fireStoreService
                                                                        .deleteHouse(
                                                                            data[index].id);
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                              MainButton(
                                                                  height: 50,
                                                                  width: 75,
                                                                  label: "No",
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context))
                                                            ],
                                                          ));
                                            },
                                            state: data[index]["state"],
                                            path: pathList[0],
                                            city: data[index]["city_name"]
                                                .toString(),
                                            gender: data[index]["gender"],
                                            availablePlaces: int.parse(
                                                data[index]
                                                    ["available_places"]),
                                            location: data[index]["location"],
                                            price:
                                                int.parse(data[index]["price"]),
                                            bed: data[index]["bed"],
                                            house: data[index]["house"],
                                          );
                                        } else {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else {
                                            return const Center(
                                              child: Text(
                                                  "You didn't post any house yet"),
                                            );
                                          }
                                        }
                                      }),
                                ),
                              );
                            });
                      } else {
                        return const Text("No posted Houses");
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
