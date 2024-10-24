import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirebaseClient {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<void> saveFoodImage({required Uint8List file}) async {
    try {
      String imageUrl = await uploadImageToStorage('image', file);
      await _firestore.collection('food').add({
        'imageLink': imageUrl,
      });
    } catch (error) {
      throw Exception(error);
    }
  }
}
