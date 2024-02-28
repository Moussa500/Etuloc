abstract class HousesModel {
  String location;
  String city;
  String price;
  String id;
  HousesModel({
    required this.location,
    required this.city,
    required this.price,
    required this.id,
  });
}
class HousePerPlacesModel extends HousesModel {
  String availablePlaces;
  String type;
  String maxPlaces;
  String loc;
  List<String> images;
  HousePerPlacesModel({
    required String location,
    required String city,
    required String price,
    required String id,
    required this.availablePlaces,
    required this.type,
    required this.maxPlaces,
    required this.images,
    required this.loc,
  }) : super(location: location, city: city, price: price,id:id);
  static List<HousePerPlacesModel> fillList() {
    List<HousePerPlacesModel> housesList = [];
    List<String> sfaxImages = [
      "assets/houses/1.webp",
      "assets/houses/2.jfif",
      "assets/houses/3.webp"
    ];
    List<String> gafsaImages = [
      "assets/houses/g1.jpg",
      "assets/houses/g2.jpg",
      "assets/houses/g2.jpg"
    ];
    housesList.add(HousePerPlacesModel(
        images: sfaxImages,
        id: "fQIZaB2e7eWo2zHpvofNyK28cXw1",
        location: "PPGC+6RW, Sfax",
        city: "Sfax",
        price: "600",
        availablePlaces: "3",
        type: "S+2",
        maxPlaces: "4",
        loc: "Hay lahbib"));
    housesList.add(HousePerPlacesModel(
        id: "Jm7X2JR8I3NEujxjIJ9wfNjFe6m1",
        images: gafsaImages,
        location: "CQHG+XHP,Gafsa",
        city: "Gafsa",
        price: "350",
        availablePlaces: "2",
        type: "S+2",
        maxPlaces: "4",
        loc: "Hay Nour"));
    return housesList;
  }
}
enum HouseStates {
  rented,
  underNegotiation,
  free,
}
class HousesPerHouseModels extends HousesModel {
  String type;
  List<String> images;
  HouseStates state;
  String loc;
  HousesPerHouseModels({
    required String location,
    required String city,
    required String id,
    required String price,
    required this.type,
    required this.images,
    required this.state,
    required this.loc,
  }) : super(location: location, city: city, price: price,id: id);

  static List<HousesPerHouseModels> fillList() {
    List<String> tunisImages = [
      "assets/houses/3.webp",
      "assets/houses/2.jfif",
      "assets/houses/1.jfif"
    ];
    List<HousesPerHouseModels> housesList = [];
    housesList.add(HousesPerHouseModels(
      id: "dfsfsdfsdd",
      images: tunisImages,
      loc: "Hay el bassatin",
      location: "R529+M8 Tunis",
      city: "Tunis",
      price: "400",
      type: "S+2",
      state: HouseStates.underNegotiation,
    ));
    return housesList;
  }
}
