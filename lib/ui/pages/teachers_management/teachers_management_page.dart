import 'package:flutter/material.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/card_info_teacher.dart';
import 'package:get/get.dart';
import 'teachers_management_controller.dart';

class TeachersManagementPage extends StatelessWidget {
  const TeachersManagementPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TeachersManagementController>(
        init: TeachersManagementController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('ادارة المعلمين'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.person_add),
                        onPressed: () => controller.addTeacher)
                  ],
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),
                      (controller.listTeachers.value?.isEmpty ?? true)
                          ? empty()
                          : listTeachers(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listTeachers() {
    final controller = Get.find<TeachersManagementController>();
    final list = controller.listTeachers.value;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoTeacher(
              teacher: list[index],
              onPressDelete: (teacher) => controller.deleteTeacher(teacher),
              onStatusChanged: (teacher, status) =>
                  controller.changeStatus(teacher, status),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة المعلمين فارغة ..',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
