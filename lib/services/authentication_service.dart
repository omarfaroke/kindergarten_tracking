import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/services/storge_services.dart';
import 'package:get/get.dart';

class AuthenticationService extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(_firebaseAuth.userChanges());
  }

  User get currentUser => _firebaseUser.value;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      }
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail(
      {@required String email,
      @required String password,
      UserModel user,
      File imageFile}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firebaseAuth.currentUser.updateProfile(displayName: user.name);

      user.id = userCredential.user.uid;

      if (imageFile != null) {
        user.photo = await StorageService.uploadImage(
            'usersImages/${user.id}', imageFile);
        _firebaseAuth.currentUser.updateProfile(photoURL: user.photo);
      }

      await Get.find<UserFirestoreService>().createUser(user);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      }
    } catch (e) {
      print(e);
    }
  }

  // Reset Password
  Future sendPasswordResetEmail({@required String email}) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return;
    }
  }
}

class UserNotFoundException implements Exception {
  UserNotFoundException();
}

class WrongPasswordException implements Exception {
  WrongPasswordException();
}

class WeakPasswordException implements Exception {
  WeakPasswordException();
}

class EmailAlreadyInUseException implements Exception {
  EmailAlreadyInUseException();
}
