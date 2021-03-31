import 'package:flutter/material.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/pages/parents_management/components/card_info_parent.dart';
import 'package:food_preservation/ui/pages/students_management/components/card_info_student.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'students_management_controller.dart';

class StudentsManagementPage extends StatelessWidget {
  const StudentsManagementPage({Key key, this.studentsForParent, })
      : super(key: key);

  final UserModel studentsForParent;
  

  @override
  Widget build(BuildContext context) {
    bool showJustParent = studentsForParent != null;

    return MixinBuilder<StudentsManagementController>(
        init: StudentsManagementController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: showJustParent
                      ?  Text('بيانات الابناء')
                      : Text('ادارة الطلاب'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.person_add),
                        onPressed: () => controller.add)
                  ],
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),
                      (controller.list.value?.isEmpty ?? true)
                          ? empty()
                          : listStudents(studentsForParent),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listStudents(UserModel parent) {
    final controller = Get.find<StudentsManagementController>();
    controller.parent=parent;
    final list = controller.listModel;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoStudent(
              student: list[index],
              onPressDelete: (student) => controller.delete(student),
              onPressEdit: (student) => controller.edit(student),
              onStatusChanged: (student, status) =>
                  controller.changeStatus(student, status),
              onPressAddParent: (student) => controller.addParent(student),
              onPressShowParent: (student) => controller.showParent(student),
              onPressShowBrothers: (student) =>
                  controller.showBrothers(student),
              justShowBrothers: studentsForParent != null,
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الطلاب فارغة ..',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
