import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage {
  final storageRef = FirebaseStorage.instance.ref();
  Future downloadHousesImages(String imageName) async {
    try {
      final gsReference = storageRef.child('houses_images/$imageName');
      final data = await gsReference.getData();
      return data;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }
}
