import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  UserType get userType => locator<AppService>().userType;
}
