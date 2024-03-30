import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/components/etudiant_cards.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/pages/Etudiant/houseperhousedetails.dart';
import 'package:projet_federe/services/auth/auth_service.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';

class EtudiantHomePage extends StatelessWidget {
  EtudiantHomePage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  //logout function
  void logout() async {
    final authService = AuthService();
    await authService.signOut();
  }

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
            GestureDetector(
              onTap: () {
                logout();
              },
              child: const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: myPrimaryColor,
                  size: 40,
                ),
              ),
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
              SizedBox(
                width: Dimensions.deviceWidth(context) * .9,
                height: Dimensions.deviceHeight(context) * .6,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                    height: Dimensions.deviceWidth(context) * .43,
                    decoration: const BoxDecoration(
                      color: myBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          color: myShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        filteredList[index] is HousePerPlacesModel
                            ? HousePerPlaceCard(
                                path: filteredList[index].images[1],
                                city: filteredList[index].city,
                                price: filteredList[index].price,
                                availablePlaces:
                                    (filteredList[index] as HousePerPlacesModel)
                                        .availablePlaces,
                                location:
                                    (filteredList[index] as HousePerPlacesModel)
                                        .loc,
                                navigate: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HouseDetails(
                                          housedetails: filteredList[index]),
                                    ),
                                  );
                                },
                              )
                            : HousePerHouseCard(
                                path: (filteredList[index]
                                        as HousesPerHouseModels)
                                    .images[0],
                                city: filteredList[index].city,
                                price: filteredList[index].price,
                                location: (filteredList[index]
                                        as HousesPerHouseModels)
                                    .loc,
                                state: (filteredList[index]
                                                as HousesPerHouseModels)
                                            .state ==
                                        HouseStates.underNegotiation
                                    ? "Under negotiation"
                                    : (filteredList[index]
                                            as HousesPerHouseModels)
                                        .state
                                        .toString(),
                              ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: filteredList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
