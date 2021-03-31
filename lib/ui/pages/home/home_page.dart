import 'package:flutter/material.dart';
import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/authentication_service.dart';
import 'package:food_preservation/ui/pages/parents_management/parents_management_page.dart';
import 'package:food_preservation/ui/pages/students_management/students_management_page.dart';
import 'package:food_preservation/ui/pages/tables_management/tables_management_page.dart';
import 'package:food_preservation/ui/pages/teachers_management/teachers_management_page.dart';
import 'package:food_preservation/ui/widgets/drawer_app.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                drawer: AppDrawer(),
                appBar: AppBar(
                  title: Text('الرئيسية'),
                  centerTitle: true,
                ),
                body: Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: buildHomeBody,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget get buildHomeBody {
    final controller = Get.find<HomeController>();

    switch (controller.userType) {
      case UserType.Admin:
        return adminHome();
      case UserType.Parent:
        return parentHome();
      case UserType.Teacher:
        return teacherHome();
      default:
    }

    return Container();
  }

  Widget adminHome() {
    final controller = Get.find<HomeController>();
    //     var size = Get.size;

    // /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24 ) / 2;
    // final double itemWidth = size.width / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GridView.count(
            // childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              CustomButton(
                label: 'ادارة المعلمين',
                onPressed: () => Get.to(TeachersManagementPage()),
              ),
              CustomButton(
                label: 'ادارة اولياء الامور',
                onPressed: () => Get.to(ParentsManagementPage()),
              ),
              CustomButton(
                label: 'ادارة الطلاب',
                onPressed: () =>Get.to(StudentsManagementPage()),
              ),
              CustomButton(
                label: 'ادارة الجداول',
                onPressed: () =>Get.to(TablesManagementPage()),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget teacherHome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Get.find<AuthenticationService>().currentUser.email ?? 'null'),
      ],
    );
  }

  Widget parentHome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Get.find<AuthenticationService>().currentUser.email ?? 'null'),
      ],
    );
  }
}
