import 'package:flutter/material.dart';
import 'package:projet_federe/Models/houses_models.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';

class HouseDetails extends StatelessWidget {
  final HousePerPlacesModel housedetails;
  const HouseDetails({
    super.key,
    required this.housedetails,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'House in ${housedetails.city} for rent',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Container(
                  height: Dimensions.deviceWidth(context) * .5,
                  width: Dimensions.deviceWidth(context),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, Index) => Container(
                            width: Dimensions.deviceWidth(context) * .95,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(37)),
                              child: ClipRRect(
                                  child: Image.asset(
                                housedetails.images[Index],
                                fit: BoxFit.fill,
                              )),
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: housedetails.images.length),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details :",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Details(housedetails: housedetails,label: "Location",info:housedetails.location,),
            Details(housedetails: housedetails, label: "price", info: "150 DT per place"),
            Details(housedetails: housedetails, label: "Available places", info: "${housedetails.availablePlaces}/${housedetails.maxPlaces}"),
            Details(housedetails: housedetails, label: "Type", info: housedetails.type),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(height: 45, width: 145, label: "Publisher Info", onPressed: (){}),
                  MainButton(height: 45, width: 145, label: "Interested", onPressed: (){})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Details extends StatelessWidget {
  final String label;
  final String info;
  const Details(
      {super.key,
      required this.housedetails,
      required this.label,
      required this.info});

  final HousePerPlacesModel housedetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20),
      child: Row(
        children: [
           Text(
            "$label :",
            style: const TextStyle(
              fontFamily: "poppins",
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            info,
            style: const TextStyle(
              color: myLabelColor,
              fontFamily: "poppins",
              fontWeight: FontWeight.w400,
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}
class Background extends StatelessWidget {
    final Widget child;
  const Background({
    required this.child,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.deviceHeight(context) * .87,
        width: Dimensions.deviceWidth(context) * 0.87,
        decoration: const BoxDecoration(
          color: myBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(35)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 6,
              color: myShadowColor,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
