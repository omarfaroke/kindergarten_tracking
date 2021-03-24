import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PathStorage {
  static final String userImages = "profiles/";
  static final String categoryImages = "category/";
  static final String productsImages = "products/";
  static final String mainAdsImage = "mainAds/";
  static final String extensionImage = ".jpg";
  static final String extensionImagePNG = ".png";
  static final String prefixImageName = "image_";

  static String buildUserImageName(String userId) {
    return PathStorage.userImages + prefixImageName + userId ??
        ' ' +
            '__' +
            DateTime.now().millisecondsSinceEpoch.toString() +
            PathStorage.extensionImage;
  }

  static String buildCategoryImageName() {
    return PathStorage.categoryImages +
        prefixImageName +
        DateTime.now().millisecondsSinceEpoch.toString() +
        PathStorage.extensionImagePNG;
  }

  static String buildMainAdsImageName() {
    return PathStorage.mainAdsImage +
        prefixImageName +
        DateTime.now().millisecondsSinceEpoch.toString() +
        PathStorage.extensionImagePNG;
  }

  static String buildProductImageName() {
    return PathStorage.productsImages +
        prefixImageName +
        DateTime.now().millisecondsSinceEpoch.toString();
  }
}

class StorageService {
  static Future<String> uploadFile(String nameFile, File dataFile) async {
    String _uploadedFileURL;

    Reference storageReference =
        FirebaseStorage.instance.ref().child(nameFile);

    try {
      await storageReference.putFile(dataFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
      return null;
    }

    print('File Uploaded');

    _uploadedFileURL = await storageReference.getDownloadURL();

    return _uploadedFileURL;
  }

  static Future<bool> deleteFile(String pathFile) async {
    bool deleteSuccessful = false;

    Reference storageReference = FirebaseStorage.instance.refFromURL(pathFile);

    await storageReference.delete().then((val) {
      deleteSuccessful = true;
      print("deleted file -- $pathFile");
    }).catchError((error) {
      print("error delete File --  $error");
    });

    return deleteSuccessful;
  }
}
