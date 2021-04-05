import 'package:flutter/material.dart';
import 'package:food_preservation/ui/pages/admin_pages/ads_management/ads_management_page.dart';
import 'package:food_preservation/ui/pages/admin_pages/parents_management/parents_management_page.dart';
import 'package:food_preservation/ui/pages/admin_pages/students_management/students_management_page.dart';
import 'package:food_preservation/ui/pages/admin_pages/tables_management/tables_management_page.dart';
import 'package:food_preservation/ui/pages/admin_pages/teachers_management/teachers_management_page.dart';
import 'package:food_preservation/ui/pages/info_class_students/info_class_students_page.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/drawer_app.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

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
                onPressed: () => Get.to(StudentsManagementPage()),
              ),
              CustomButton(
                label: 'ادارة الجداول',
                onPressed: () => Get.to(TablesManagementPage()),
              ),
              CustomButton(
                label: 'ادارة الاعلانات',
                onPressed: () => Get.to(AdsManagementPage()),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget teacherHome() {
    final controller = Get.find<HomeController>();

    bool notApprove = (controller.user.status == null) ||
        (controller.user.status == Status.notApprove);

    if (notApprove) {
      return notApproveWidget();
    }

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
                label: 'بيانات الطلاب',
                onPressed: () => Get.to(InfoClassStudentsPage()),
              ),
              CustomButton(
                label: 'الواجبات',
                onPressed: () => controller.openListDutiesForTeacher,
              ),
              CustomButton(
                label: 'الرسائل',
                onPressed: () => controller.openListMsg,
              ),
              CustomButton(
                label: ' الاعلانات',
                onPressed: () => controller.openListAds,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget parentHome() {
    final controller = Get.find<HomeController>();

    bool notApprove = (controller.user.status == null) ||
        (controller.user.status == Status.notApprove);

    if (notApprove) {
      return notApproveWidget();
    }

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
                label: 'جداول الحصص',
                onPressed: () => controller.openListTabl,
              ),
              CustomButton(
                label: 'الواجبات',
                onPressed: () => controller.openListDuties,
              ),
              CustomButton(
                label: 'السلوك',
                onPressed: () => controller.openListBehavior,
              ),
              CustomButton(
                label: 'متابعة خروج الطالب',
                onPressed: () => controller.openListFollowExit,
              ),
              CustomButton(
                label: ' الرسائل',
                onPressed: () => controller.openListMsg,
              ),
              CustomButton(
                label: ' الاعلانات',
                onPressed: () => controller.openListAds,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget notApproveWidget() {
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'حسابك غير مفعل ! \n الرجاء التواصل مع ادارة التطبيق لتفعيل حسابك ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.lightPrimary,
                    fontFamily: "DinNextLtW23",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () => controller.signOut(),
          child: Text(
            'تسجيل خروح',
            style: TextStyle(color: Colors.white),
          ),
          color: AppColors.lightPrimary,
        ),
      ],
    );
  }
}
