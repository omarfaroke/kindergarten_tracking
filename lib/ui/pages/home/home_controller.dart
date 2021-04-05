import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/authentication_service.dart';
import 'package:food_preservation/services/db/parent_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/ui/pages/list_ads/list_ads_page.dart';
import 'package:food_preservation/ui/pages/list_behavior/list_behavior_page.dart';
import 'package:food_preservation/ui/pages/list_conversation/list_conversation_page.dart';
import 'package:food_preservation/ui/pages/list_duties/list_duties_page.dart';
import 'package:food_preservation/ui/pages/list_followExit/list_followExit_page.dart';
import 'package:food_preservation/ui/pages/list_students/list_students_page.dart';
import 'package:food_preservation/ui/pages/list_tables/list_table_page.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  UserType get userType => locator<AppService>().userType;

  UserModel get user => locator<AppService>().currentUser;

  Future<List<String>> get getLevelAllChildren async {
    UserModel parent = locator<AppService>().currentUser;

    List<Student> children = await Get.find<ParentFirestoreService>()
        .getStudentsForParent(parentId: parent.id);

    List<String> list = List();
    children.forEach((child) => list.add(child.level));

    return list;
  }

  get openListTabl async {
    UserModel parent = locator<AppService>().currentUser;
    Student student = await Get.to(ListStudentsPage(
        parent: parent,
        onSelected: (student) async => Get.to(ListTablePage(
              level: [student.level],
            ))));

    // if (student != null) {
    //   Get.to(ListTablePage(
    //     level: [student.level],
    //   ));
    // }
  }

  get openListDuties async {
    UserModel parent = locator<AppService>().currentUser;
    Student student = await Get.to(ListStudentsPage(
      parent: parent,
      onSelected: (student) async => Get.to(ListDutiesPage(
        level: [student.level],
        forParent: true,
      )),
    ));

    // if (student != null) {
    //   Get.to(ListDutiesPage(
    //     level: [student.level],
    //     forParent: true,
    //   ));
    // }
  }

  get openListDutiesForTeacher async {
    String level = locator<AppService>().getCustomDataFromDb('level');

    if (level != null) {
      Get.to(ListDutiesPage(
        level: [level],
        forParent: false,
      ));
    } else {
      Get.find<AuthenticationService>().signOut();
    }
  }

  get openListBehavior async {
    UserModel parent = locator<AppService>().currentUser;
    Student student = await Get.to(ListStudentsPage(
      parent: parent,
      onSelected: (student) async => Get.to(ListBehaviorPage(
        student: student,
      )),
    ));

    // if (student != null) {
    //   Get.to(ListBehaviorPage(
    //     student: student,
    //   ));
    // }
  }

  get openListFollowExit async {
    UserModel parent = locator<AppService>().currentUser;
    Student student = await Get.to(ListStudentsPage(
      parent: parent,
      onSelected: (student) async => Get.to(ListFollowExitPage(
        student: student,
      )),
    ));

    // if (student != null) {
    //   Get.to(ListFollowExitPage(
    //     student: student,
    //   ));
    // }
  }

  get openListMsg async {
    await Get.to(ListConversationPage());
  }

  get openListAds async {
    await Get.to(ListAdsPage());
  }

  signOut() {
    Get.find<AuthenticationService>().signOut();
  }
}
