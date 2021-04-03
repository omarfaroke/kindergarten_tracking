import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'edit_student_controller.dart';

class EditStudentPage extends StatelessWidget {
  const EditStudentPage({
    Key key,
    @required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditStudentController>(
      init: EditStudentController(student),
      builder: (controller) => SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('تعديل بيانات الطالب'),
            centerTitle: true,
          ),
          body: ReactiveFormBuilder(
            form: () => controller.form,
            builder: (context, form, child) {
              return FadeAnimation(
                1.6,
                TempletForm(
                  formCenter: false,
                  children: [
                    _sizeBetween,
                    _buildImageUser(),
                    _sizeBetween,
                    ListDropdown(
                      formControlName: 'level',
                      lable: 'المستوى الدراسي',
                      values: levels,
                    ),
                    _sizeBetween,
                    CustomTextField(
                      formControlName: 'name',
                      hintText: 'اسم الطالب',
                      prefixIcon: Icons.perm_identity,
                      validationMessages: (control) => {...validatorRequiredMs},
                      onSubmitted: () => form.focus('address'),
                    ),
                    _sizeBetween,
                    CustomTextField(
                      formControlName: 'address',
                      hintText: 'العنوان',
                      prefixIcon: Icons.location_city_sharp,
                      validationMessages: (control) => {
                        ...validatorRequiredMs,
                      },
                      minLines: 2,
                      maxLines: 4,
                    ),
                    _sizeBetween,
                    _sizeBetween,
                    controller.isBusy
                        ? Loading()
                        : CustomSubmitButton(
                            label: "تعديل",
                            onPressed: () => controller.edit(),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      )),
    );
  }

  get _sizeBetween => SizedBox(
        height: 20,
      );

  _buildImageUser() {
    File imageFile;
    EditStudentController controller = Get.find<EditStudentController>();

    return ReactiveValueListenableBuilder(
        formControlName: 'photo',
        builder: (context, controllerForm, child) {
          String value = controllerForm.value;
          bool isUrl = value?.isURL ?? false;

          return value != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    GFImageOverlay(
                      height: Get.height / 6,
                      width: Get.height / 6,
                      shape: BoxShape.circle,
                      image: isUrl
                          ? Image.network(controllerForm.value).image
                          : Image.file(File(controllerForm.value)).image,
                      boxFit: BoxFit.cover,
                    ),
                    Positioned(
                        top: 1,
                        left: Get.height / 11,
                        child: IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              if (isUrl) {
                                controller.deletePhoto(value);
                              }
                              controllerForm.value = null;
                            })),
                  ],
                )
              : InkWell(
                  onTap: () async {
                    imageFile = await pickImage();
                    controller.form.control('photo').value =
                        imageFile?.path ?? null;
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        child: Icon(
                          Icons.photo_camera,
                          size: Get.height / 10,
                        ),
                      )),
                );
        });
  }
}
