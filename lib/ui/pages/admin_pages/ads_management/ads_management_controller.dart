import 'package:food_preservation/models/ads.dart';
import 'package:food_preservation/services/db/ads_firestore_service.dart';
import 'package:food_preservation/ui/pages/admin_pages/add_ads/add_ads_page.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';

class AdsManagementController extends GetxController {
  Rx<List<Ads>> list = new Rx<List<Ads>>();

  List<Ads> get listModel {
    return list.value.toList();
  }

  get add {
    Get.to(AddAdsPage());
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() {
    list.bindStream(Get.find<AdsFirestoreService>().adsStream());
    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

  delete(Ads ads) async {
    // String name = teacher.info.name;
    bool ok = await defaultDialog(
      title: 'حذف الاعلان',
      middleText: 'هل تريد حذف هذا الاعلان ؟',
    );

    if (ok) {
      await Get.find<AdsFirestoreService>().delete(ads.id);
      showTextSuccess('تم الحذف بنجاح');
      // update();
    }
  }
}
