import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class ParentFirestoreService extends GetxService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> addParentForStudent(
      {@required String parentId, @required String studentId}) async {
    try {
      await Get.find<StudentsFirestoreService>()
          .updateParentStudent(studentId, parentId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Student>> getStudentsForParent({String parentId}) async {
    try {
      QuerySnapshot listData = await _fireStore
          .collection('students')
          .where('parentId', isEqualTo: parentId)
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

  Future<bool> deleteAllStudentsForParent(String parentId) async {
    try {
      List<Student> listStudents =
          await getStudentsForParent(parentId: parentId);

      if (listStudents == null) {
        return false;
      }
      for (Student s in listStudents) {
        await Get.find<StudentsFirestoreService>().deleteStudent(s.id);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<UserModel>> parentsStream() {
    Stream<List<UserModel>> streamUserModel = Get.find<UserFirestoreService>()
        .usersStream(userType: UserType.Parent.index);
    return streamUserModel.map<List<UserModel>>((event) {
      
      if(event == null || event.isEmpty){
        return List<UserModel>();
      }
      
      return event.where((element) => element.type == UserType.Parent.index).toList() ;
    });
  }
}
