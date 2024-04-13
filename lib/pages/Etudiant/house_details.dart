import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/components/profile_list_tile.dart';
import 'package:projet_federe/pages/Etudiant/publisher_info.dart';
import 'package:projet_federe/services/firestore/firestore.dart';

class HouseDetails extends StatelessWidget {
  final String id;
  HouseDetails({super.key, required this.id});
  final FireStoreService _fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: _fireStoreService.getValueFromFirestore(
              FirebaseFirestore.instance.collection("houses").doc(id)),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final data = snapshot.data!;
              List<String> imagesList = data["images_url"].split(',');
              return SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: Dimensions.deviceWidth(context),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 25,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: imagesList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: Dimensions.deviceWidth(context) * .6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: ClipRect(
                                      child: Image.network(
                                    imagesList[index],
                                    fit: BoxFit.cover,
                                  )));
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 25,
                          left: 25,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Details :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                fontFamily: "poppins"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 15),
                        child: ProfileListTile(
                            label: "Location :",
                            content: Text(data["location"])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 15),
                        child: ProfileListTile(
                            label: "Price :",
                            content: Text(
                              data["price"],
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Poppins",
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 15),
                        child: ProfileListTile(
                            label: "Gender :",
                            content: Text(
                              data["gender"],
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Poppins"),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 12, top: 15),
                          child: data["bed : "] == true
                              ? ProfileListTile(
                                  label: "Available Places :",
                                  content: Text(data["places"]))
                              : ProfileListTile(
                                  label: "State :",
                                  content: Text(
                                    data["state"],
                                    style: const TextStyle(
                                        fontSize: 20, fontFamily: "Poppins"),
                                  ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 15),
                        child: ProfileListTile(
                            label: "City :",
                            content: Text(
                              data["city_name"],
                              style: const TextStyle(
                                  fontSize: 20, fontFamily: "Poppins"),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MainButton(
                                height: 50,
                                width: 150,
                                label: "Publisher info",
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PublisherInfo(uid: data["uid"])))),
                            const SizedBox(
                              width: 20,
                            ),
                            MainButton(
                                height: 50,
                                width: 150,
                                label: "Interested",
                                onPressed: () {
                                  print("value: ${data["uid"]}");
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          })),
    );
  }
}
