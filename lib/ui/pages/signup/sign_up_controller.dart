import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/authentication_service.dart';
import 'package:food_preservation/services/db/teacher_firestore_service.dart';
import 'package:food_preservation/ui/pages/home/home_page.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:food_preservation/util/function_helpers.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpController extends GetxController {
  final _form = fb.group({
    'name': FormControl(
      validators: [
        Validators.required,
      ],
    ),
    'email': FormControl(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl(
      validators: [
        Validators.required,
        Validators.minLength(6),
      ],
    ),
    'confirmPassword': FormControl(
      validators: [
        Validators.required,
      ],
    ),
    'photo': FormControl(
      validators: [],
    ),
    'address': FormControl(
      validators: [
        Validators.required,
      ],
    ),
    'location': FormControl(
      validators: [],
    ),
    'note': FormControl(
      validators: [],
    ),
    'phone': FormControl(
      validators: [
        Validators.required,
        Validators.number,
      ],
    ),
    'type': FormControl<int>(
      validators: [
        Validators.required,
        Validators.number,
      ],
    ),
    'level': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  }, [
    Validators.mustMatch('password', 'confirmPassword'),
  ]);

  FormGroup get form => _form;

  bool _isBusy = false;

  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
    update();
  }

  Future signUp() async {
    print('signUp');
    if (_form.valid) {
      //
      try {
        isBusy = true;

        Map mapFrom = _form.value;

        UserModel user = UserModel.fromMap(mapFrom);
        String password = mapFrom['password'];

        File imageFile =
            mapFrom['photo'] != null ? File(mapFrom['photo']) : null;

        String id = await Get.find<AuthenticationService>().signUpWithEmail(
            email: user.email,
            password: password,
            user: user,
            imageFile: imageFile);

        if (user.type == UserType.Teacher.index) {
          await Get.find<TeacherFirestoreService>()
              .createTeacher(id: id, level: mapFrom['level']);

          locator<AppService>()
              .setCustomDataToDb(key: 'level', data: mapFrom['level']);
        }
      } catch (e) {
        if (e is EmailAlreadyInUseException) {
          showSnackBar(
              title: "خطأ في التسجيل",
              message: "البريد المستخدم موجود مسبقاً !");
        } else {
          showSnackBar(
            title: "خطأ في التسجيل",
            message: '',
          );
        }
        isBusy = false;

        return;
      }

      showTextSuccess('تم تسجيل البيانات بنجاح');

      isBusy = false;
      afterSuccessSignUp;
    } else {
      _form.markAllAsTouched();

      return false;
    }

    return true;
  }

  get afterSuccessSignUp {
    // Get.offUntil(HomePage(), (v) => false);

    Get.offAll(HomePage());
  }

  Future<LocationResult> showMapView(BuildContext context) async {
    String apiKey = 'AIzaSyCYH1e8Jk3brXKinzKU7OCb5DmONdwBJMs';

    LatLng latLng = LatLng(24.706218959658127, 46.669893711805344); // الرياض

    LocationResult result = await showLocationPicker(context, apiKey,
        requiredGPS: false,
        resultCardConfirmIcon: Center(child: Text('تحديد')),
        initialCenter: latLng,
        automaticallyAnimateToCurrentLocation: false,
        myLocationButtonEnabled: true,
        layersButtonEnabled: true,
        resultCardAlignment: Alignment.bottomCenter,
        countries: ['YE', 'SA'],
        language: 'AR');

    print(result);

    if (result != null) {
      form.control('location').value = latLngToString(result.latLng);
    } else {
      form.control('location').value = null;
    }

    return result;
  }
}
