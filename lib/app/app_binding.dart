import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/cache_files_service.dart';
import 'package:food_preservation/services/db/parent_firestore_service.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/services/db/teacher_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import '../services/authentication_service.dart';
import '../services/db/table_firestore_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationService>(AuthenticationService(), permanent: true);
    Get.put<AppService>(AppService());
    Get.lazyPut(() => UserFirestoreService());
    Get.lazyPut(() => TeacherFirestoreService());
    Get.lazyPut(() => TableFirestoreService());
    Get.lazyPut(() => ParentFirestoreService());
    Get.lazyPut(() => StudentsFirestoreService());
    Get.lazyPut(() => CacheFilesService());
    // Get.put<HomeController>( HomeController());
  }
}
