abstract class HousesModel {
  String location;
  String city;
  String price;
  HousesModel({
    required this.location,
    required this.city,
    required this.price,
  });
}
class HousePerPlacesModel extends HousesModel {
  String availablePlaces;
  String type;
  String maxPlaces;
  List<String> images;
  HousePerPlacesModel({
    required String location,
    required String city,
    required String price,
    required this.availablePlaces,
    required this.type,
    required this.maxPlaces,
    required this.images,
  }) : super(location: location, city: city, price: price);
  @override
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
      location: "PPGC+6RW, Sfax",
      city: "Sfax",
      price: "600",
      availablePlaces: "3",
      type: "S+2",
      maxPlaces: "4",
    ));
    housesList.add(HousePerPlacesModel(
      images: gafsaImages,
      location: "CQHG+XHP،Rue Gandhi,Gafsa",
      city: "Gafsa",
      price: "350",
      availablePlaces: "2",
      type: "S+2",
      maxPlaces: "4",
    ));
    return housesList;
  }
}
class HousesPerHouseModels extends HousesModel {
  String type;
  bool rented;
  bool underNegotiation;
  List<String> images;

  HousesPerHouseModels({
    required String location,
    required String city,
    required String price,
    required this.type,
    required this.rented,
    required this.underNegotiation,
    required this.images,
  }) : super(location: location, city: city, price: price);

  static List<HousesPerHouseModels> fillList() {
    List<String> tunisImages = [
      "assets/houses/3.webp",
      "assets/houses/2.jfif",
      "assets/houses/1.jfif"
    ];
    List<HousesPerHouseModels> housesList = [];
    housesList.add(HousesPerHouseModels(
      images: tunisImages,
      location: "R529+M8 Tunis",
      city: "Tunis",
      price: "400",
      type: "S+2",
      rented: true,
      underNegotiation: false,
    ));
    return housesList;
  }
}