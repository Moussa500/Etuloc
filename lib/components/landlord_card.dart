import 'package:flutter/material.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';

class LandLordCard extends StatelessWidget {
  final String path;
  final String city;
  final String gender;
  final int price;
  final String location;
  final int? availablePlaces;
  final String? state;

  const LandLordCard(
      {super.key,
      required this.path,
      required this.city,
      required this.gender,
      required this.location,
      this.availablePlaces,
      this.state,
      required this.price});
  @override
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
              child: SubFields(label: "price", value: "${price.toString()} DT"),
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
              child: availablePlaces!=null?SubFields(
                  label:"available places",
                  value: "${availablePlaces.toString()} free places"):SubFields(label: "state", value:"$state"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: MainButton(
                  height: 35, width: 73, label: "Edit", onPressed: () {}),
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
