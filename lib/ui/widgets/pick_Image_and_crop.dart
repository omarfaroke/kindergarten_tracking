import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<File> pickImage(
    {bool camera = true,
    bool gallery = true,
    double maxHeight = 1080,
    double maxWidth = 1024}) async {
  File image;

  image = await Get.dialog(
    SimpleDialog(
      children: <Widget>[
        Visibility(
          visible: camera,
          child: ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("من الكاميرا"),
            onTap: () async {
              image = await pickImageFromCamera(
                  maxWidth: maxWidth, maxHeight: maxHeight);
              Get.back(result: image);
            },
          ),
        ),
        Visibility(
          visible: gallery,
          child: ListTile(
            leading: Icon(Icons.image),
            title: Text("من المعرض"),
            onTap: () async {
              image = await pickImageFromGallery(
                  maxWidth: maxWidth, maxHeight: maxHeight);
              Get.back(result: image);
            },
          ),
        ),
      ],
    ),
  );

  return image;
}

Future<File> pickImageFromGallery(
    {double maxHeight = 1080, double maxWidth = 1024}) async {
  File imageFile;
  PickedFile _pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: maxWidth,
      maxHeight: maxHeight);
  if (_pickedFile != null) {
    imageFile = File(_pickedFile.path);
  }
  return imageFile;
}

Future<File> pickImageFromCamera(
    {double maxHeight = 1080, double maxWidth = 1024}) async {
  File imageFile;
  PickedFile _pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: maxWidth,
      maxHeight: maxHeight);
  if (_pickedFile != null) {
    imageFile = File(_pickedFile.path);
  }

  return imageFile;
}
