import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/ui/pages/add_student/add_student_page.dart';
import 'package:food_preservation/ui/pages/edit_parent/edit_parent_page.dart';
import 'package:food_preservation/ui/pages/edit_student/edit_student_page.dart';
import 'package:food_preservation/ui/pages/parents_management/parents_management_page.dart';
import 'package:food_preservation/ui/pages/students_management/students_management_page.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class StudentsManagementController extends GetxController {
  Rx<List<Student>> list = new Rx<List<Student>>();

  UserModel _parent;

  set parent(UserModel value) => _parent = value;

  List<Student> get listModel {
    if (_parent == null) {
      return list.value;
    }

    return list.value
        .where((element) => element.parentId == _parent.id)
        .toList();
  }

  get add {
    Get.to(AddStudentPage());
  }

  @override
  void onInit() {
    list.bindStream(Get.find<StudentsFirestoreService>().studentsStream());
    super.onInit();
  }

  delete(Student student) async {
    // String name = teacher.info.name;
    bool ok = await defaultDialog(
      title: 'حذف الطالب',
      middleText: 'هل تريد حذف هذا الطالب ؟',
    );

    if (ok) {
      await Get.find<StudentsFirestoreService>().deleteStudent(student.id);
      showTextSuccess('تم الحذف بنجاح');
      // update();
    }
  }

  changeStatus(Student student, bool status) async {
    String statusLabel = status ? 'تفعيل' : 'الغاء تفعيل';
    bool ok = await defaultDialog(
      title: statusLabel,
      middleText: 'هل تريد $statusLabel هذا الطالب ؟',
    );

    if (ok) {
      await Get.find<StudentsFirestoreService>().updateStudentStatus(
          student.id, status ? Status.approve : Status.notApprove);
      showTextSuccess('تم التعديل بنجاح');
      // update();
    }
  }

  edit(Student student) async {
    await Get.to(EditStudentPage(
      student: student,
    ));
  }

  addParent(Student student) async {
    UserModel parent = await Get.to(ParentsManagementPage(
      showSelected: true,
    ));

    if (parent == null) {
      showTextSuccess('لم يتم تحديد ولي امر');
      return;
    }

    bool ok = await Get.find<StudentsFirestoreService>()
        .updateParentStudent(student.id, parent.id);

    if (ok) {
      showTextSuccess('تم إضافة ولي الامر بنجاح');
    } else {
      showTextError('خطأ في اضافة ولي الامر');
    }
  }

  showParent(Student student) async {
    UserModel parent =
        await Get.find<UserFirestoreService>().getUser(student.parentId);

    if (parent == null) {
      showTextError('خطأ في جلب بيانات ولي الامر');
      return;
    }

    await Get.to(EditParentPage(
      parent: parent,
      justShow: true,
    ));
  }

  showBrothers(Student student) async {
    print('showBrothers');
        UserModel parent =
        await Get.find<UserFirestoreService>().getUser(student.parentId);

    if (parent == null) {
      showTextError('خطأ في جلب بيانات ولي الامر');
      return;
    }

    await Get.to(StudentsManagementPage(studentsForParent: parent,) , preventDuplicates: false);
  }
}
