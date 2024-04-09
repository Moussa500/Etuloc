import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/components/my_drawer.dart';
import 'package:projet_federe/components/student_card.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/auth/auth_service.dart';
import 'package:projet_federe/services/firestore/firestore.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';

class EtudiantHomePage extends StatelessWidget {
  EtudiantHomePage({super.key});
  //logout function
  void logout() async {
    final authService = AuthService();
    await authService.signOut();
  }
  final User? currentUser= FirebaseAuth.instance.currentUser;
  FireStoreService _fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    var searchTextProvider = Provider.of<SearchTextProvider>(context);
    return SafeArea(
      child: Scaffold(
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
                                      List<String> pathList =
                                          data[index]["images_url"].split(',');
                                      return StudentCard(
                                        ontap: () async {},
                                        state: data[index]["state"],
                                        path: pathList[0],
                                        city:
                                            data[index]["city_name"].toString(),
                                        gender: data[index]["gender"],
                                        availablePlaces: int.parse(
                                            data[index]["available_places"]),
                                        location: data[index]["location"],
                                        price: int.parse(data[index]["price"]),
                                        bed: data[index]["bed"],
                                        house: data[index]["house"],
                                      );
                                    }
                                  )
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("There is no houses at the moment"),
                          );
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
