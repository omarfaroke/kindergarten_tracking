import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/db/parent_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/ui/pages/add_parent/add_parent_page.dart';
import 'package:food_preservation/ui/pages/edit_parent/edit_parent_page.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class ParentsManagementController extends GetxController {
  Rx<List<UserModel>> listParents = new Rx<List<UserModel>>();

  List<UserModel> get listModel => listParents.value;

  get add {
    Get.to(AddParentPage());
  }

  @override
  void onInit() {
    listParents.bindStream(Get.find<ParentFirestoreService>().parentsStream());
    super.onInit();
  }

  delete(UserModel parent) async {
    // String name = teacher.info.name;
    bool ok = await defaultDialog(
      title: 'حذف ولي امر',
      middleText: 'هل تريد حذف ولي الامر هذا ؟',
    );

    if (ok) {
      await Get.find<UserFirestoreService>().deleteUser(parent.id);
      showTextSuccess('تم الحذف بنجاح');
      // update();
    }
  }

  changeStatus(UserModel parent, bool status) async {
    String statusLabel = status ? 'تفعيل' : 'الغاء تفعيل';
    bool ok = await defaultDialog(
      title: statusLabel,
      middleText: 'هل تريد $statusLabel ولي الامر هذا ؟',
    );

    if (ok) {
      await Get.find<UserFirestoreService>().updateUserStatus(
          parent.id, status ? Status.approve : Status.notApprove);
      showTextSuccess('تم التعديل بنجاح');
      // update();
    }
  }

  edit(UserModel parent) async {
    await Get.to(EditParentPage(
      parent: parent,
    ));
  }

  selected(UserModel parent) {
    Get.back(result:parent );
  }
}
