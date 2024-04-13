import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/components/background.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/profile_list_tile.dart';
import 'package:projet_federe/pages/chat_page/chat_page.dart';
import 'package:projet_federe/services/firestore/firestore.dart';
import 'package:svg_flutter/svg.dart';

class PublisherInfo extends StatelessWidget {
  final String uid;
  PublisherInfo({super.key, required this.uid});
  final FireStoreService _fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Background(
        elements: FutureBuilder(
            future: _fireStoreService.getValueFromFirestore(FirebaseFirestore
                .instance
                .collection("landlordsProfile")
                .doc(uid)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100,),
                        ClipOval(child: Image.network(data["pdp"],height: 200,width: 200,)),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(data["name"],style: const TextStyle(fontSize: 40),),
                        const SizedBox(
                          height: 25,
                        ),
                        ProfileListTile(
                            label: "Rating",
                            content: data["number_ratings"] == 0
                                ? const Text("Not rated yet",style: TextStyle(fontSize: 20),)
                                : SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ListView.builder(
                                        itemCount: data["number_ratings"],
                                        itemBuilder: (context, index) {
                                          return SvgPicture.asset(
                                              'assets/images/star.svg');
                                        }),
                                  )),
                                  const SizedBox(height: 25,),
                                  ProfileListTile(label: "Posted Houses", content: Text(data["posted_houses"].toString(),style: const TextStyle(fontSize: 20),)),
                                  const SizedBox(height: 25,),
                                  ProfileListTile(label: "Rented Houses", content: Text(data["rented_houses"].toString(),style:const TextStyle(fontSize: 20),)),
                                  data["city_visibility"]==true?ProfileListTile(label: "City", content: data["city"]):const SizedBox(),
                                  data["phone_visibility"]==true?ProfileListTile(label: "City", content: data["phone_number"]):const SizedBox(),
                                  const SizedBox(height: 25,),
                                  MainButton(height: 50, width: 120, label: "Contact", onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(receiverID: data["uid"],receiverName: data["name"],receiverPDP: data["pdp"],)));
                                  }),
                      ],
                    ),
                  );
                }
              }
              return const Text("Error loading publisher infos");
            }),
      ),
    );
  }
}
