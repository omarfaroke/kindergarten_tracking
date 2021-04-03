import 'package:flutter/material.dart';
import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/behavior.dart';
import 'package:food_preservation/models/follow_exit.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import '../../../util/extensions.dart';

class InfoClassStudentController extends GetxController {
  Rx<List<Student>> list = new Rx<List<Student>>();
  Rx<List<FollowExit>> listFollowExit = new Rx<List<FollowExit>>();
  Rx<List<Behavior>> listBehavior = new Rx<List<Behavior>>();

  String _level;

  var _loading = true.obs;

  bool get loading => _loading.value;

  InfoClassStudentController() {
    _level = locator<AppService>().getCustomDataFromDb('level');
  }

  List<Student> get listModel {
    return list.value.where((element) => element.level == _level).toList();
  }

  @override
  void onInit() {
    listFollowExit
        .bindStream(Get.find<StudentsFirestoreService>().getTodayFollowExit());
    listBehavior
        .bindStream(Get.find<StudentsFirestoreService>().getTodayBehavior());

    list.bindStream(Get.find<StudentsFirestoreService>().studentsStream());

    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

  getBehavior(Student student) {
    Behavior behavior;

    listBehavior.value ??= List();

    behavior = listBehavior.value?.firstWhere(
            (element) => element.studentId == student.id,
            orElse: () => null) ??
        null;

    if (behavior == null) {
      behavior = new Behavior();

      behavior.studentId = student.id;
      behavior.date = DateTime.now().justDate.millisecondsSinceEpoch;
      behavior.behavior = listBehaviorName['1'];
      Get.find<StudentsFirestoreService>().setBehavior(behavior);
      // listBehavior.value.add(behavior);
    }
    return behavior;
  }

  getFollowExit(Student student) {
    FollowExit followExit;

    listFollowExit.value ??= List();

    followExit = listFollowExit.value?.firstWhere(
            (element) => element.studentId == student.id,
            orElse: () => null) ??
        null;

    if (followExit == null) {
      followExit = new FollowExit();

      followExit.studentId = student.id;
      followExit.date = DateTime.now().justDate.millisecondsSinceEpoch;
      followExit.timeExit = DateTime.now().formatTime();
      Get.find<StudentsFirestoreService>().setFollowExit(followExit);
      // listFollowExit.value.add(followExit);
    }
    return followExit;
  }

  onSelected(Student student) async {
    Get.back(result: student);
  }

  onEditFollowExit(FollowExit obj, bool value) async {
    if (!value) {
      obj.timeExit = DateTime.now().formatTime();
    } else {
      obj.timeExit = '';
    }

    try {
      await Get.find<StudentsFirestoreService>().setFollowExit(obj);
      //  showTextSuccess('تم التعديل بنجاح');
    } catch (e) {
      showTextError('فشل تعديل البيانات');
    }

    update();
  }

  onEditBehavior(Behavior obj, String value) async {
    obj.behavior = value;

    try {
      await Get.find<StudentsFirestoreService>().setBehavior(obj);
      //  showTextSuccess('تم التعديل بنجاح');
    } catch (e) {
      showTextError('فشل تعديل البيانات');
    }

    update();
  }
}
