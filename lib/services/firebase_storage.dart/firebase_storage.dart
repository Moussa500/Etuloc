import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  // upload image to Firebase Storage
  Future<String> uploadImage(String bucketName, String filePath) async {
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('$bucketName/$filePath');
    final uploadTask = imageRef.putFile(File(filePath));
    final snapshot = await uploadTask.snapshot;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> uploadMultipleImages(List<XFile> images, String bucketName) async {
  List<String> imageUrls = [];

  try {
    for (int i = 0; i < images.length; i++) {
      String filePath = images[i].path;  // Extract file path
      String imageUrl = await uploadImage(bucketName, filePath);
      imageUrls.add(imageUrl);
    }
  } catch (error) {
    // Handle upload errors gracefully
    print("Error uploading images: $error");
    // Consider reporting errors back to the user or UI
  }

  return imageUrls.join(',');
}

}
