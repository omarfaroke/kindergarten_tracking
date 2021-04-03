import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/teacher.dart';
import 'package:food_preservation/models/teacher.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import 'user_firestore_service.dart';

class TeacherFirestoreService extends GetxService {
  final CollectionReference _teacherCollectionReference =
      FirebaseFirestore.instance.collection('teachers');

  Future<bool> createTeacher(
      {@required String id, @required String level}) async {
    try {
      await _teacherCollectionReference.doc(id).set({'level': level});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTeacherLevel(
      {@required String id, @required String level}) async {
    try {
      await _teacherCollectionReference.doc(id).set({'level': level});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Teacher> getTeacherInfo(String id) async {
    try {
      final user = await Get.find<UserFirestoreService>().getUser(id);
      DocumentSnapshot levelData =
          await _teacherCollectionReference.doc(id).get();
      String level = levelData.data()['level'];
      Teacher teacher = new Teacher(info: user, level: level);

      return teacher;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getLevel(String id) async {
    try {
      DocumentSnapshot levelData =
          await _teacherCollectionReference.doc(id).get();
      String level = levelData.data()['level'];

      return level;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteTeacher(String uid) async {
    try {
      bool ok = await Get.find<UserFirestoreService>().deleteUser(uid);

      if (!ok) {
        return false;
      }
      await _teacherCollectionReference.doc(uid).delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Teacher>> teachersStream() {
    Stream<List<TeacherLevel>> streamTeacherLevel =
        _teacherCollectionReference.snapshots().map((QuerySnapshot query) {
      List<TeacherLevel> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['teacherId'] = element.id;
        retVal.add(TeacherLevel.fromMap(mapData));
      });
      return retVal;
    });

    Stream<List<UserModel>> streamUserModel = Get.find<UserFirestoreService>()
        .usersStream(userType: UserType.Teacher.index);

    return rxdart.Rx.combineLatest2(streamUserModel, streamTeacherLevel, (
      List<UserModel> users,
      List<TeacherLevel> listLevel,
    ) {
      List<UserModel> listTeachers = List();

      if (users != null) {
        listTeachers = users
            .where((element) => element.type == UserType.Teacher.index)
            .toList();
      }

      print('rxdart.Rx.combineLatest2');
      return listTeachers.map<Teacher>((user) {
        String level = listLevel
            .firstWhere((element) => element.teacherId == user.id,
                orElse: () => null)
            ?.level;

        return Teacher(info: user, level: level);
      }).toList();
    }).asBroadcastStream();
    // ..skipWhile((element) => element == null || element.isEmpty);
  }
}
