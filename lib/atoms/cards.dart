import 'package:flutter/material.dart';
import 'package:projet_federe/atoms/colors.dart';

class HousePerPlaceCard extends StatelessWidget {
  final String path;
  final String city;
  final String price;
  final String availablePlaces;
  final String location;
  const HousePerPlaceCard({super.key,required this.path,
  required this.city,
  required this.price,
  required this.availablePlaces,
  required this.location,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),height: 143,width: 107,
            child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(30)),child: Image.asset(path,fit: BoxFit.fill,),),),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17,left: 17),
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
            SubFields(label: "price",value: "$price DT"),
            SubFields(label: "Location", value: location ),
            SubFields(label: "State", value: "$availablePlaces free places"),
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
        fontSize: 18,
        color: myLabelColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class HousePerHouseCard extends StatelessWidget {
  const HousePerHouseCard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
