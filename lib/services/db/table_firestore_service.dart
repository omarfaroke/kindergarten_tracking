import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/table.dart';
import 'package:get/get.dart';
import '../storge_services.dart';

class TableFirestoreService extends GetxService {
  final CollectionReference _tableCollectionReference =
      FirebaseFirestore.instance.collection('tables');

  Future<bool> createTable({@required TableModel table}) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';
      File file = new File(table.pathFile);
      String urlFile = await StorageService.uploadFile(fileName, file);
      table.pathFile = urlFile;
      DocumentReference doc =
          await _tableCollectionReference.add({});
          table.id = doc.id;
      await _tableCollectionReference.doc(doc.id).set(table.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteTable(TableModel table) async {
    try {
      await _tableCollectionReference.doc(table.id).delete();
      await StorageService.deleteFile(table.pathFile);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<TableModel>> tablesStream({int userType}) {
    return _tableCollectionReference
        .orderBy('createDate', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<TableModel> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(TableModel.fromMap(mapData));
      });
      return retVal;
    });
  }
}
