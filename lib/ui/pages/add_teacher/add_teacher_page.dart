import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'add_teacher_controller.dart';

class AddTeacherPage extends StatelessWidget {
  const AddTeacherPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTeacherController>(
      init: AddTeacherController(),
      builder: (controller) => SafeArea(
          child: Scaffold(
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: ReactiveFormBuilder(
                form: () => controller.form,
                builder: (context, form, child) {
                  return FadeAnimation(
                    1.6,
                    TempletForm(
                      title: 'إضافة معلم',
                      formCenter: false,
                      children: [
                        _sizeBetween,
                        _buildImageUser(),
                        _sizeBetween,
                        CustomTextField(
                          formControlName: 'name',
                          hintText: 'اسم المعلم',
                          prefixIcon: Icons.perm_identity,
                          validationMessages: (control) =>
                              {...validatorRequiredMs},
                          onSubmitted: () => form.focus('email'),
                        ),
                        _sizeBetween,
                        CustomTextField(
                          formControlName: 'email',
                          hintText: 'البريد الالكتروني',
                          prefixIcon: Icons.email,
                          validationMessages: (control) => {
                            ...validatorRequiredMs,
                            ValidationMessage.email:
                                'صيغة البريد الاكتروني غير صحيحة'
                          },
                        ),
                        _sizeBetween,
                        CustomTextField(
                          formControlName: 'phone',
                          hintText: ' رقم التلفون',
                          prefixIcon: Icons.phone_android,
                          isNumber: true,
                          validationMessages: (control) => {
                            ...validatorRequiredMs,
                          },
                        ),
                        _sizeBetween,
                        CustomTextField(
                          formControlName: 'note',
                          hintText: ' ملاحظات',
                          prefixIcon: Icons.note,
                          validationMessages: (control) => {
                            ...validatorRequiredMs,
                          },
                          minLines: 2,
                          maxLines: 4,
                        ),
                        _sizeBetween,
                        CustomTextField(
                          formControlName: 'address',
                          hintText: ' العنوان',
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
                                label: "إضافة",
                                onPressed: () => controller.add(),
                              ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      )),
    );
  }

  get _sizeBetween => SizedBox(
        height: 20,
      );

  _buildImageUser() {
    File imageFile;
    AddTeacherController controller = Get.find<AddTeacherController>();

    return ReactiveValueListenableBuilder(
        formControlName: 'photo',
        builder: (context, controllerForm, child) {
          return controllerForm.value != null
              ? GFImageOverlay(
                  height: Get.height / 6,
                  width: Get.height / 6,
                  shape: BoxShape.circle,
                  image: Image.file(File(controllerForm.value)).image,
                  boxFit: BoxFit.cover,
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
