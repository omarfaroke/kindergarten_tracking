import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:get/get.dart';

class ListStudentController extends GetxController {
  Rx<List<Student>> list = new Rx<List<Student>>();

  UserModel _parent;

  ListStudentController(UserModel parent) {
    _parent = parent;
  }

  List<Student> get listModel {
    if (_parent == null) {
      return list.value;
    }

    return list.value
        .where((element) => element.parentId == _parent.id)
        .toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() {
    list.bindStream(Get.find<StudentsFirestoreService>().studentsStream());
    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

  onSelected(Student student) async {
    Get.back(result: student);
  }
}
