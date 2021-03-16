import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/db/teacher_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/ui/pages/home/home_controller.dart';
import '../services/authentication_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationService>(AuthenticationService(), permanent: true);
    Get.put<AppService>(AppService());
    Get.lazyPut(() => UserFirestoreService());
    Get.lazyPut(() => TeacherFirestoreService());
    // Get.put<HomeController>( HomeController());
  }
}
