import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/follow_exit.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:get/get.dart';

class ListFollowExitController extends GetxController {
  Rx<List<FollowExit>> list = new Rx<List<FollowExit>>();

  Student _student;

  ListFollowExitController(Student student) {
    _student = student;
  }

  List<FollowExit> get listModel {
    return list.value.toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() {
    list.bindStream(
        Get.find<StudentsFirestoreService>().followExitStream(_student.id));
    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }
}
