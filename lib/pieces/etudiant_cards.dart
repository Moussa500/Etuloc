import 'package:flutter/material.dart';
import 'package:projet_federe/pieces/buttons.dart';
import 'package:projet_federe/pieces/colors.dart';

class HousePerPlaceCard extends StatelessWidget {
  final String path;
  final String city;
  final String price;
  final String availablePlaces;
  final String location;
  final void Function() navigate;
  const HousePerPlaceCard({
    super.key,
    required this.navigate,
    required this.path,
    required this.city,
    required this.price,
    required this.availablePlaces,
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: 143,
            width: 107,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                path,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "House in $city",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: "poppins",
                  color: myTitlesColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11, bottom: 5),
              child: SubFields(label: "price", value: "$price DT"),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 11),
              child: SubFields(label: "Location", value: location),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 11),
              child: SubFields(
                  label: "State", value: "$availablePlaces free places"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: MainButton(
                  height: 35, width: 73, label: "View", onPressed:navigate),
            ),
          ],
        )
      ],
    );
  }
}

class SubFields extends StatelessWidget {
  const SubFields({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$label : $value",
      style: const TextStyle(
        fontSize: 15,
        color: myLabelColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
class HousePerHouseCard extends StatelessWidget {
  final String path;
  final String city;
  final String price;
  final String location;
  final String state;
  const HousePerHouseCard({
    super.key,
    required this.path,
    required this.city,
    required this.price,
    required this.location,
    required this.state,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: 143,
            width: 107,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                path,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "House in $city",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: "poppins",
                  color: myTitlesColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11, bottom: 5),
              child: SubFields(label: "price", value: "$price DT"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 11),
              child: SubFields(label: "Location", value: location),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11, bottom: 5),
              child: SubFields(label: "State", value: "$state"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: MainButton(
                buttonColor: myLabelColor,
                  height: 35, width: 73, label: "View", onPressed: () {}),
            ),
          ],
        )
      ],
    );
  }
}
