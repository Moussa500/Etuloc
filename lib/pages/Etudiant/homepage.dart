import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/atoms/cards.dart';
import 'package:projet_federe/atoms/colors.dart';
import 'package:projet_federe/atoms/device_dimensions.dart';
import 'package:projet_federe/atoms/textfields.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';

class EtudiantHomePage extends StatelessWidget {
  EtudiantHomePage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TextFieldsState>(context);
    var houseProvider = Provider.of<HomeState>(context);
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
          actions: const [
            Icon(
              Icons.settings,
              color: myPrimaryColor,
              size: 40,
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
                                color: myShadowColor
                              ),
                            ]
                          ),
                          child: Row(
                            children: [
                              houseProvider.combinedList[index] is HousePerPlacesModel?HousePerPlaceCard(path:houseProvider.housePerPlace[index].images[1], city:houseProvider.combinedList[index].city, price:houseProvider.combinedList[index].price, availablePlaces: houseProvider.housePerPlace[index].availablePlaces,location: houseProvider.housePerPlace[index].loc,):HousePerHouseCard(path: houseProvider.housePerHouse[0].images[0], city: houseProvider.combinedList[index].city, price: houseProvider.combinedList[index].price, location: houseProvider.housePerHouse[0].loc, state:houseProvider.housePerHouse[0].state==HouseStates.underNegotiation?"Under negotiation":houseProvider.housePerHouse[0].state.toString()),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: houseProvider.combinedList.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
