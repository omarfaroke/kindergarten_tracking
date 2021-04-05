import 'package:food_preservation/models/ads.dart';
import 'package:food_preservation/services/db/ads_firestore_service.dart';
import 'package:get/get.dart';

class ListAdsController extends GetxController {
  Rx<List<Ads>> list = new Rx<List<Ads>>();

  List<Ads> get listModel {
    return list.value.toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() {
    list.bindStream(Get.find<AdsFirestoreService>().adsStream());
    super.onInit();
    list.listen(
      (listData) {
        _loading.value = false;
        // update();
      },
      onDone: () => _loading.value = false,
      onError: () => _loading.value = false,
    );
  }
}
