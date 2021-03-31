import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'edit_parent_controller.dart';

class EditParentPage extends StatelessWidget {
  const EditParentPage({
    Key key,
    @required this.parent,
    this.justShow = false,
  }) : super(key: key);

  final UserModel parent;
  final bool justShow;

  @override
  Widget build(BuildContext context) {
    bool canEdit = !justShow;
    return GetBuilder<EditParentController>(
      init: EditParentController(parent),
      builder: (controller) => SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: !canEdit
                ? Text(' بيانات ولي الامر')
                : Text('تعديل بيانات ولي الامر'),
            centerTitle: true,
            actions: [
              justShow
                  ? canEdit
                      ? IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            canEdit = false;
                            controller.update();
                          })
                      : IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            canEdit = true;
                            controller.update();
                          })
                  : SizedBox()
            ],
          ),
          body: ReactiveFormBuilder(
            form: () => controller.form,
            builder: (context, form, child) {
              return FadeAnimation(
                1.6,
                TempletForm(
                  formCenter: false,
                  disable: !canEdit,
                  children: [
                    _sizeBetween,
                    _buildImageUser(),
                    _sizeBetween,
                    CustomTextField(
                      formControlName: 'name',
                      hintText: 'اسم ولي الامر',
                      prefixIcon: Icons.perm_identity,
                      validationMessages: (control) => {...validatorRequiredMs},
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
                      readOnly: true,
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
                    Visibility(
                      visible: canEdit,
                      child: controller.isBusy
                          ? Loading()
                          : CustomSubmitButton(
                              label: "تعديل",
                              onPressed: () => controller.edit(),
                            ),
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
    EditParentController controller = Get.find<EditParentController>();

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
