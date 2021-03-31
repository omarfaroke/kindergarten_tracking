import 'dart:io';

import 'package:food_preservation/models/teacher.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/authentication_service.dart';
import 'package:food_preservation/services/db/teacher_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/services/storge_services.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditTeacherController extends GetxController {
  Teacher _teacher;

  EditTeacherController(Teacher teacher) {
    _teacher = teacher;

    setUpDefualtValue;
  }

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
    'level': FormControl<String>(
      validators: [
        Validators.required,
        Validators.number,
      ],
    ),
  }, []);

  FormGroup get form => _form;

  get setUpDefualtValue {
    form.updateValue({..._teacher.info.toMap(), 'level': _teacher.level});
  }

  bool _isBusy = false;

  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
    update();
  }

  Future edit() async {
    print('edit');
    if (_form.valid) {
      //
      try {
        isBusy = true;

        Map mapFrom = _form.value;

        UserModel user = UserModel.fromMap(mapFrom);

        user.id = _teacher.info.id;
        user.status = _teacher.info.status;

        bool pathPhotoIsUrl = user.photo?.isURL ?? false;

        File imageFile;
        if (!pathPhotoIsUrl) {
          imageFile = mapFrom['photo'] != null ? File(mapFrom['photo']) : null;
        }

        user.type = UserType.Teacher.index;

        if (imageFile != null) {
          user.photo = await StorageService.uploadFile(
              'usersImages/${user.id}', imageFile);
        }

        await Get.find<UserFirestoreService>().updateUserInfo(user);

        await Get.find<TeacherFirestoreService>()
            .updateTeacherLevel(id: user.id, level: mapFrom['level']);
      } catch (e) {
        showSnackBar(
          title: "خطأ في التعديل",
          message: '',
        );

        isBusy = false;

        return;
      }

      showTextSuccess('تم تعديل البيانات بنجاح');

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

  Future<bool> deletePhoto(String value) async {
    return await StorageService.deleteFile(value);
  }
}
