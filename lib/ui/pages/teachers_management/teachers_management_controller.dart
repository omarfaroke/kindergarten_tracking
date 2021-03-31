import 'package:flutter/material.dart';
import 'package:food_preservation/models/teacher.dart';
import 'package:food_preservation/services/db/teacher_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/ui/pages/add_teacher/add_teacher_page.dart';
import 'package:food_preservation/ui/pages/edit_teacher/edit_teacher_page.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class TeachersManagementController extends GetxController {
  Rx<List<Teacher>> listTeachers = new Rx<List<Teacher>>();

  List<Teacher> get teachers => listTeachers.value;

  get addTeacher {
    Get.to(AddTeacherPage());
  }

  @override
  void onInit() {
    listTeachers
        .bindStream(Get.find<TeacherFirestoreService>().teachersStream());
    super.onInit();
  }

  deleteTeacher(Teacher teacher) async {
    // String name = teacher.info.name;
    bool ok = await defaultDialog(
      title: 'حذف المعلم',
      middleText: 'هل تريد حذف هذا المعلم ؟',
    );

    if (ok) {
      await Get.find<TeacherFirestoreService>().deleteTeacher(teacher.info.id);
      showTextSuccess('تم الحذف بنجاح');
      // update();
    }
  }

  changeStatus(Teacher teacher, bool status) async {
    String statusLabel = status ? 'تفعيل' : 'الغاء تفعيل';
    bool ok = await defaultDialog(
      title: statusLabel,
      middleText: 'هل تريد $statusLabel هذا المعلم ؟',
    );

    if (ok) {
      await Get.find<UserFirestoreService>().updateUserStatus(
          teacher.info.id, status ? Status.approve : Status.notApprove);
      showTextSuccess('تم التعديل بنجاح');
      // update();
    }
  }

  editTeacher(Teacher teacher) async {
    await Get.to(EditTeacherPage(
      teacher: teacher,
    ));
  }
}
