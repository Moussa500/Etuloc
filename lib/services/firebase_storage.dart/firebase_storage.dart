import 'dart:io'; // Import 'dart:io' for File class

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  // upload image to Firebase Storage
  Future<String> uploadImage(String bucketName,String filePath) async {
    // Get a reference to Firebase Storage
    final storage = FirebaseStorage.instance;
    // Create a reference to the upload location
    final imageRef = storage.ref().child('$bucketName/$filePath');
    // Upload the image to Firebase Storage
    final uploadTask = imageRef.putFile(File(filePath));
    // Wait for the upload to complete
    final snapshot = await uploadTask.snapshot;
    // Get the download URL
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}
