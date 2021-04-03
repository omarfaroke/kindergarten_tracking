import 'package:flutter/material.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';

import 'components/card_info_followExit.dart';
import 'list_followExit_controller.dart';

class ListFollowExitPage extends StatelessWidget {
  const ListFollowExitPage({
    Key key,
    @required this.student,
    this.titleAppBar,
  }) : super(key: key);

  final Student student;
  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListFollowExitController>(
        init: ListFollowExitController(student),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: titleAppBar != null
                      ? Text(titleAppBar)
                      : Text(
                          'متابعة خروج للطفل : ${student.name.split(' ').first}'),
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
    final controller = Get.find<ListFollowExitController>();
    final list = controller.listModel;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoFollowExit(
              followExit: list[index],
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة السلوك فارغة',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
