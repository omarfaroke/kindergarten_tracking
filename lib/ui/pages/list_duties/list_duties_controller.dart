import 'package:food_preservation/models/duties.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/ui/pages/add_duties/add_duties_page.dart';
import 'package:get/get.dart';

class ListDutiesController extends GetxController {
  Rx<List<Duties>> list = new Rx<List<Duties>>();

  List<String> _level;

  ListDutiesController(List<String> level) {
    _level = level;
  }

  List<Duties> get listModel {
    
    
    
    return list.value
        .where((element) => _level.contains(element.level))
        .toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() {
    list.bindStream(Get.find<StudentsFirestoreService>().dutiesStream(_level));
    super.onInit();
    list.listen(
      (listData) {
        _loading.value = false;
        // update();
      },
      onDone: () => _loading.value = false,
      onError: () => _loading.value = false,
    );
  }

  // get setupInfoLevel async {
  //   UserModel user = locator<AppService>().currentUser;
  //   Teacher teacher =
  //       await Get.find<TeacherFirestoreService>().getTeacherInfo(user.id);
  //   _level = List();
  //   _level.add(teacher.level);
  // }

  get add async {
    Get.to(AddDutiesPage(level: _level.first));
  }
}
