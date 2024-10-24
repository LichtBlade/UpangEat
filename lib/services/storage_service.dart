import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier {
  //* Firebase storage
  final firebaseStorage = FirebaseStorage.instance;

  // Image URLS stored here
  List<String> _imageUrls = [];

  // loading status
  bool _isLoading = false;

  // uplaoading status
  bool _isUploading = false;

  //* GETTERS
  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  //* READ IMAGES
  Future<void> fetchFoodImages() async {
    // start loading
    _isLoading = true;

    final ListResult result = await firebaseStorage.ref('foods/').listAll();

    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    _imageUrls = urls;

    // loading finished
    _isLoading = false;

    // update ui
    notifyListeners();
  }

  //* DELETE IMAGES

  Future<void> deleteImage(String imageUrl) async {
    try {
      _imageUrls.remove(imageUrl);

      final String path = extractPathFromURL(imageUrl);

      await firebaseStorage.ref(path).delete();
    } catch (e) {
      throw Exception(e);
    }

    //update UI
    notifyListeners();
  }

  //* UPLOAD IMAGES

  Future<void> uploadImage() async {
    _isUploading = true;

    notifyListeners();

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);

    try {
      String filePath = 'food/${DateTime.now()}.png';

      await firebaseStorage.ref(filePath).putFile(file);

      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      _imageUrls.add(downloadUrl);
    } catch (e) {
      throw Exception(e);
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  //* Other methods

  String extractPathFromURL(String url) {
    Uri uri = Uri.parse(url);

    String encodedPath = uri.pathSegments.last;

    return Uri.decodeComponent(encodedPath);
  }
}
