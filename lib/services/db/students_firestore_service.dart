import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/duties.dart';
import 'package:food_preservation/models/follow_exit.dart';
import 'package:food_preservation/models/student.dart';
import 'package:get/get.dart';

import '../storge_services.dart';
import '../../util/extensions.dart';

class StudentsFirestoreService extends GetxService {
  final CollectionReference _studentsCollectionReference =
      FirebaseFirestore.instance.collection('students');

  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<bool> createStudent(Student student, {File imageFile}) async {
    DocumentReference doc = await _studentsCollectionReference.add({});
    student.id = doc.id;

    if (imageFile != null) {
      student.photo = await StorageService.uploadFile(
          'studentsImages/${student.id}', imageFile);
    }

    await _studentsCollectionReference
        .doc(student.id)
        .set(student.toMap()..addAll(updatedAtField));

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

  Stream<List<Student>> studentsStream() {
    return _studentsCollectionReference
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

  Stream<List<Student>> studentsStreamByParentId({String parentId}) {
    return _studentsCollectionReference
        .orderBy(updatedAtKey, descending: true)
        .where('parentId', isEqualTo: parentId)
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

  //Behavior
  Future<bool> setBehavior(Behavior behavior) async {
    behavior.id = behavior.studentId + behavior.date.toString();
    await _firebase
        .collection('Behavior')
        .doc(behavior.id)
        .set(behavior.toMap());
    return true;
  }

  Stream<List<Behavior>> getTodayBehavior() {
    int todayDate = DateTime.now().justDate.millisecondsSinceEpoch;

    return _firebase
            .collection('Behavior')
            .orderBy('date', descending: true)
            .where('date', isEqualTo: todayDate)
            .snapshots(includeMetadataChanges: true)
            .map<List<Behavior>>((QuerySnapshot query) {
          List<Behavior> retVal = List();
          query.docs.forEach((element) {
            Map mapData = element.data();
            mapData['id'] = element.id;
            retVal.add(Behavior.fromMap(mapData));
          });
          return retVal;
        }) ??
        List();
  }

  Stream<List<Behavior>> behaviorStream(String studentId) {
    return _firebase
        .collection('Behavior')
        .where('studentId', isEqualTo: studentId)
        // .orderBy('date', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<Behavior> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(Behavior.fromMap(mapData));
      });
      return retVal;
    });
  }

  //Duties
  Future<bool> createDuties(Duties duties) async {
    DocumentReference doc = await _firebase.collection('Duties').add({});
    duties.id = doc.id;
    await _firebase.collection('Duties').doc(duties.id).set(duties.toMap());
    return true;
  }

  Stream<List<Duties>> dutiesStream(List<String> level) {
    return _firebase
        .collection('Duties')
        // .where('level', whereIn: level)
        .orderBy('date', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<Duties> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(Duties.fromMap(mapData));
      });
      return retVal;
    });
  }

  //FollowExit
  Future<bool> setFollowExit(FollowExit followExit) async {
    followExit.id = followExit.studentId + followExit.date.toString();
    await _firebase
        .collection('FollowExit')
        .doc(followExit.id)
        .set(followExit.toMap());
    return true;
  }

  Stream<List<FollowExit>> getTodayFollowExit() {
    int todayDate = DateTime.now().justDate.millisecondsSinceEpoch;

    return _firebase
            .collection('FollowExit')
            .orderBy('date', descending: true)
            .where('date', isEqualTo: todayDate)
            .snapshots(includeMetadataChanges: true)
            .map((QuerySnapshot query) {
          List<FollowExit> retVal = List();
          query.docs.forEach((element) {
            Map mapData = element.data();
            mapData['id'] = element.id;
            retVal.add(FollowExit.fromMap(mapData));
          });
          return retVal;
        }) ??
        List();
  }

  Stream<List<FollowExit>> followExitStream(String studentId) {
    return _firebase
        .collection('FollowExit')
        .where('studentId', isEqualTo: studentId)
        // .orderBy('date', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<FollowExit> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(FollowExit.fromMap(mapData));
      });
      return retVal;
    });
  }
}
