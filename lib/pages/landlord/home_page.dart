import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/etudiant_cards.dart';
import 'package:projet_federe/components/landlord_card.dart';
import 'package:projet_federe/components/my_drawer.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/firestore/firestore.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';

class LandLordHomePage extends StatelessWidget {
  LandLordHomePage({super.key});
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
        onPressed: () {},
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
