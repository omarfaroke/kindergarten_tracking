import 'package:flutter/material.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';

import 'components/card_info_student.dart';
import 'info_class_students_controller.dart';

class InfoClassStudentsPage extends StatelessWidget {
  const InfoClassStudentsPage({
    Key key,
    this.titleAppBar,
  }) : super(key: key);

  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<InfoClassStudentController>(
        init: InfoClassStudentController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: titleAppBar != null
                      ? Text(titleAppBar)
                      : Text('بيانات الطلاب'),
                  centerTitle: true,
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.loading
                          ? Loading()
                          : (controller.listModel?.isEmpty ?? true)
                              ? empty()
                              : listStudents(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listStudents() {
    final controller = Get.find<InfoClassStudentController>();
    final list = controller.listModel;
    controller.listBehavior;
    controller.listFollowExit;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoStudent(
              student: list[index],
              behavior: controller.getBehavior(list[index]),
              followExit: controller.getFollowExit(list[index]),
              onEditBehavior: (obj, value) =>
                  controller.onEditBehavior(obj, value),
              onEditFollowExit: (obj, value) =>
                  controller.onEditFollowExit(obj, value),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الطلاب فارغة !',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
