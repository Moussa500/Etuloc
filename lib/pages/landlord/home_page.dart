import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/my_drawer.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';

class LandLordHomePage extends StatelessWidget {
  LandLordHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var houseProvider = Provider.of<HomeState>(context);
    var searchTextProvider = Provider.of<SearchTextProvider>(context);
    List<dynamic> filteredList = houseProvider.combinedList.where((item){
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
        floatingActionButton: FloatingActionButton(onPressed: (){},backgroundColor: myPrimaryColor,child: const Icon(Icons.add,color: Colors.white,),),
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            'Hello ${FirebaseAuth.instance.currentUser!.displayName}',
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
            ],
          ),
        ),
      ),
    );
  }
}
