import 'package:flutter/material.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';

import 'components/card_info_student.dart';
import 'list_students_controller.dart';

class ListStudentsPage extends StatelessWidget {
  const ListStudentsPage({
    Key key,
    @required this.parent,
    this.titleAppBar, this.onSelected,
  }) : super(key: key);

  final UserModel parent;
  
  final String titleAppBar;
  final Function(Student student) onSelected;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListStudentController>(
        init: ListStudentController(parent),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: titleAppBar != null
                      ? Text(titleAppBar)
                      : parent == null
                          ? Text('بيانات الطلاب')
                          : Text('حدد الطفل اولاً'),
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
    final controller = Get.find<ListStudentController>();
    final list = controller.listModel;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoStudent(
              student: list[index],
              onSelected: (student) => onSelected(student) // controller.onSelected(student),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        parent != null
            ? 'لا يوجد لديك أبناء مسجلين لدينا !'
            : 'قائمة الطلاب فارغة !',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
