import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  //* Firebase storage
  final firebaseStorage = FirebaseStorage.instance;

  // Image URLS stored here
  List<String> _imageUrls = [];
  String _imageUrl = '';

  // loading status
  bool _isLoading = false;

  // uplaoading status
  bool _isUploading = false;

  //* GETTERS
  List<String> get imageUrls => _imageUrls;
  String get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  //* READ IMAGES
  Future<void> fetchImages(String path) async {
    // start loading
    _isLoading = true;

    final ListResult result = await firebaseStorage.ref(path).listAll();

    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    _imageUrls = urls;

    // loading finished
    _isLoading = false;
  }

  // Future<void> fetchImage(String path) async {
  //   // start loading
  //   _isLoading = true;

  //   final result = firebaseStorage.ref(path);

  //   final String url = await Future.wait(result.getDownloadURL());

  //   _imageUrl = url;

  //   // loading finished
  //   _isLoading = false;
  // }

  //* DELETE IMAGES
  Future<void> deleteImage(String imageUrl) async {
    try {
      _imageUrls.remove(imageUrl);

      final String path = extractPathFromURL(imageUrl);

      await firebaseStorage.ref(path).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  //* UPLOAD IMAGES
  Future<void> uploadImage(String path, XFile? image) async {

    if (image == null) return;

    File file = File(image.path);

    try {
      String filePath = '$path${DateTime.now()}.png';

      await firebaseStorage.ref(filePath).putFile(file);

      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      _imageUrls.add(downloadUrl);
    } catch (e) {
      throw Exception(e);
    } 
  }

  //* Other methods
  String extractPathFromURL(String url) {
    Uri uri = Uri.parse(url);

    String encodedPath = uri.pathSegments.last;

    return Uri.decodeComponent(encodedPath);
  }
}
