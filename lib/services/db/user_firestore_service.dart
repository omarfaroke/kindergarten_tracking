import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:get/get.dart';

class UserFirestoreService extends GetxService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<bool> createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUserInfo(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot userData =
          await _usersCollectionReference.doc(uid).get();
      if (userData.exists) {
        return UserModel.fromMap(userData.data());
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<UserModel>> usersStream() {
    return _usersCollectionReference
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(UserModel.fromMap(mapData));
      });
      return retVal;
    });
  }
}
