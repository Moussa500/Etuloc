import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/landlord_card.dart';
import 'package:projet_federe/components/my_drawer.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/firebase_storage.dart/firebase_storage.dart';
import 'package:projet_federe/services/firestore/firestore.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';

class LandLordHomePage extends StatefulWidget {
  LandLordHomePage({super.key});

  @override
  State<LandLordHomePage> createState() => _LandLordHomePageState();
}

class _LandLordHomePageState extends State<LandLordHomePage> {
  StorageService _storageService = StorageService();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController rentTypeController = TextEditingController();
  TextEditingController moreInfoController = TextEditingController();
  Future<List<String>> uploadImages(List<XFile> images) async {
    final futures = images
        .map((image) => _storageService.uploadImage('houses', image.path));
    final imageUrls = await Future.wait(futures);
    return imageUrls;
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
                              final List<XFile?> images =
                                  await picker.pickMultiImage();
                              if (images != []) {
                              }
                            },
                            child: Image.asset("assets/images/upload.png"))),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                        label: "Location", controller: locationController),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(label: "Type", controller: typeController),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                        label: "Gender", controller: genderController),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                        label: "Type of renting ",
                        controller: moreInfoController),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                        label: "type more infos ",
                        controller: moreInfoController),
                    const SizedBox(
                      height: 25,
                    ),
                    MainButton(
                        height: 70, width: 120, label: "Post", onPressed: () {})
                  ],
                ),
              ),
            ));
  }

  final FireStoreService fireStoreService = FireStoreService();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var houseProvider = Provider.of<HomeState>(context);
    var searchTextProvider = Provider.of<SearchTextProvider>(context);
    List<dynamic> filteredList = houseProvider.combinedList.where((item) {
      if (item is HousePerPlacesModel) {
        return item.city
            .toLowerCase()
            .contains(searchTextProvider.searchText.toLowerCase());
      } else if (item is HousesPerHouseModels) {
        return item.city
            .toLowerCase()
            .contains(searchTextProvider.searchText.toLowerCase());
      }
      return false;
    }).toList();
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
            FutureBuilder(
                future: fireStoreService.getSpecificDocuments(
                    currentUser!.uid, "houses"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return const LandLordCard(
                            path: "path",
                            city: "city",
                            gender: "gender",
                            location: "location",
                            price: 600,
                            state: "rented",
                          );
                        },
                      );
                    } else {
                      return const Text("You don't have any posted houses yet");
                    }
                  }
                }),
          ],
        ),
      ),
    ));
  }
}
