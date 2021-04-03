import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:get/get.dart';

class ListBehaviorController extends GetxController {
  Rx<List<Behavior>> list = new Rx<List<Behavior>>();

  Student _student;

  ListBehaviorController(Student student) {
    _student = student;
  }

  List<Behavior> get listModel {
    return list.value.toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() {
    list.bindStream(
        Get.find<StudentsFirestoreService>().behaviorStream(_student.id));
    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

}
