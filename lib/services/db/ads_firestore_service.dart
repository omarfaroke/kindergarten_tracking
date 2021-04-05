import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/ads.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:get/get.dart';

import '../storge_services.dart';

class AdsFirestoreService extends GetxService {
  final CollectionReference _adsCollectionReference =
      FirebaseFirestore.instance.collection('ads');

  Future<bool> create(Ads ads, {File imageFile}) async {
    DocumentReference doc = await _adsCollectionReference.add({});
    ads.id = doc.id;

    if (imageFile != null) {
      ads.photo =
          await StorageService.uploadFile('adsImages/${ads.id}', imageFile);
    }

    await _adsCollectionReference
        .doc(ads.id)
        .set(ads.toMap()..addAll(updatedAtField));

    return true;
  }

  Future<bool> delete(String id) async {
    try {
      await _adsCollectionReference.doc(id).delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Ads>> adsStream() {
    return _adsCollectionReference
        .orderBy(updatedAtKey, descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<Ads> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(Ads.fromMap(mapData));
      });
      return retVal;
    });
  }
}
