import 'package:flutter/material.dart';
import 'package:projet_federe/components/buttons.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/device_dimensions.dart';
import 'package:projet_federe/services/firestore/firestore.dart';

class StudentCard extends StatelessWidget {
  final String path;
  final String city;
  final String gender;
  final int price;
  final String location;
  final int? availablePlaces;
  final String? state;
  final bool bed;
  final bool house;
  final void Function()? ontap;

  const StudentCard({
    super.key,
    required this.path,
    required this.ontap,
    required this.city,
    required this.gender,
    required this.location,
    this.availablePlaces,
    this.state,
    required this.price,
    required this.bed,
    required this.house,
  });
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: Dimensions.deviceWidth(context) * .7,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 6,
              )
            ]),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 143,
                width: 107,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Image.network(
                    path,
                    fit: BoxFit.fill,
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
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "poppins",
                        color: myTitlesColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11, bottom: 5),
                    child: SubFields(
                        label: "price", value: "${price.toString()} DT"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 11),
                    child: SubFields(label: "City", value: city),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 11),
                    child: bed == true
                        ? SubFields(
                            label: "available places",
                            value: "${availablePlaces.toString()} free places")
                        : SubFields(label: "state", value: "$state"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 125,top: 10),
                    child: Row(
                      children: [
                        MainButton(
                            height: 35,
                            width: 73,
                            label: "View",
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
