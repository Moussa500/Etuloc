import 'package:flutter/material.dart';
import 'package:projet_federe/Models/houses_models.dart';

class HomeState extends ChangeNotifier {
  List<HousePerPlacesModel> housePerPlace = HousePerPlacesModel.fillList();
  List<HousesPerHouseModels> housePerHouse = HousesPerHouseModels.fillList();
  List<HousesModel> combinedList = [];
  HomeState() {
    combinedList.addAll(housePerPlace);
    combinedList.addAll(housePerHouse);
  }
}
