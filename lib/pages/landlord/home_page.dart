import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/pieces/buttons.dart';
import 'package:projet_federe/pieces/etudiant_cards.dart';
import 'package:projet_federe/pieces/colors.dart';
import 'package:projet_federe/pieces/device_dimensions.dart';
import 'package:projet_federe/pieces/textfields.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:projet_federe/stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';

class LandLordHomePage extends StatelessWidget {
  LandLordHomePage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TextFieldsState>(context);
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
        appBar: AppBar(
          title: Text(
            'Hello ${user!.displayName}',
            style: const TextStyle(
              fontFamily: "poppins",
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: CircleAvatar(),
                onTap: () {
                  Navigator.pushNamed(context, 'profile');
                },
              ),
            )
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
              MainButton(
                  height: 55,
                  width: 221,
                  label: 'Post',
                  onPressed: () {
                    Navigator.pushNamed(context, "post");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
