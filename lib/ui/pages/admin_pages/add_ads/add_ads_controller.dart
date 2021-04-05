import 'dart:io';

import 'package:food_preservation/models/ads.dart';
import 'package:food_preservation/services/db/ads_firestore_service.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddAdsController extends GetxController {
  final _form = fb.group({
    // 'title': FormControl(
    //   validators: [
    //     Validators.required,
    //   ],
    // ),
    'photo': FormControl(
      validators: [],
    ),
    'text': FormControl(
      validators: [
        Validators.required,
      ],
    ),
  }, []);

  FormGroup get form => _form;

  bool _isBusy = false;

  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
    update();
  }

  Future add() async {
    print('add');
    if (_form.valid) {
      //
      try {
        isBusy = true;

        Map mapFrom = _form.value;

        Ads ads = Ads.fromMap(mapFrom);
        ads.date = DateTime.now().millisecondsSinceEpoch;

        File imageFile =
            mapFrom['photo'] != null ? File(mapFrom['photo']) : null;

        bool ok = await Get.find<AdsFirestoreService>()
            .create(ads, imageFile: imageFile);

        if (!ok) {
          throw new Exception();
        }
      } catch (e) {
        showSnackBar(
          title: "خطأ في إضافة البيانات",
          message: '',
        );

        isBusy = false;

        return;
      }

      showTextSuccess('تم إضافة البيانات بنجاح');

      isBusy = false;
      afterSuccessAdd;
    } else {
      _form.markAllAsTouched();

      return false;
    }

    return true;
  }

  get afterSuccessAdd {
    Get.back();
  }
}
