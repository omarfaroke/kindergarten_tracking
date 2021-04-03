import 'dart:io';

import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/services/storge_services.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditStudentController extends GetxController {
  Student _student;

  EditStudentController(Student student) {
    _student = student;

    setUpDefualtValue;
  }

  final _form = fb.group({
    'name': FormControl(
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
    'level': FormControl<String>(
      validators: [
        Validators.required,
        Validators.number,
      ],
    ),
  }, []);

  FormGroup get form => _form;

  get setUpDefualtValue {
    form.updateValue({..._student.toMap()});
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

        Student student = Student.fromMap(mapFrom);

        student.id = _student.id;
        student.status = _student.status;

        bool pathPhotoIsUrl = student.photo?.isURL ?? false;

        File imageFile;
        if (!pathPhotoIsUrl) {
          imageFile = mapFrom['photo'] != null ? File(mapFrom['photo']) : null;
        }

        if (imageFile != null) {
          student.photo = await StorageService.uploadFile(
              'studentsImages/${student.id}', imageFile);
        }

        await Get.find<StudentsFirestoreService>().updateStudentInfo(student);
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
