import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/student.dart';
import 'package:get/get.dart';

import '../storge_services.dart';

class StudentsFirestoreService extends GetxService {
  final CollectionReference _studentsCollectionReference =
      FirebaseFirestore.instance.collection('students');

  Future<bool> createStudent(Student student, {File imageFile}) async {
    DocumentReference doc = await _studentsCollectionReference.add({});
    student.id = doc.id;
    await _studentsCollectionReference
        .doc(student.id)
        .set(student.toMap()..addAll(updatedAtField));

    if (imageFile != null) {
      student.photo = await StorageService.uploadFile(
          'studentsImages/${student.id}', imageFile);
    }

    return true;
  }

  Future<bool> updateStudentInfo(Student student) async {
    await _studentsCollectionReference
        .doc(student.id)
        .set(student.toMap()..addAll(updatedAtField));
    return true;
  }

  Future<bool> updateStudentStatus(String id, String status) async {
    try {
      await _studentsCollectionReference
          .doc(id)
          .update({'status': status}..addAll(updatedAtField));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateParentStudent(String studentId, String parentId) async {
    try {
      await _studentsCollectionReference
          .doc(studentId)
          .update({'parentId': parentId}..addAll(updatedAtField));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Student> getStudent(String id) async {
    try {
      DocumentSnapshot studentData =
          await _studentsCollectionReference.doc(id).get();
      if (studentData.exists) {
        return Student.fromMap(studentData.data());
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteStudent(String uid) async {
    try {
      await _studentsCollectionReference.doc(uid).delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Student>> studentsStream({int studentType}) {
    return _studentsCollectionReference
        // .where('type', isEqualTo: studentType) // notWorking ! TODO:
        .orderBy(updatedAtKey, descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<Student> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(Student.fromMap(mapData));
      });
      return retVal;
    });
  }

  Future<List<Student>> studentsFuture({int studentType}) async {
    try {
      QuerySnapshot listData = await _studentsCollectionReference
          .orderBy(updatedAtKey, descending: true)
          .get();
      List<Student> retVal = List();
      for (QueryDocumentSnapshot doc in listData.docs) {
        Map mapData = doc.data();
        mapData['id'] = doc.id;
        retVal.add(Student.fromMap(mapData));
      }
      return retVal;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
