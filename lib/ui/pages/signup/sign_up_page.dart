import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key key,
    @required this.typeUser,
  }) : super(key: key);

  final int typeUser;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        controller.form.control('type').value = this.typeUser;
        if (this.typeUser == UserType.Parent.index) {
          controller.form.control('level').value = 1;
        }
        return SafeArea(
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
                        title: 'تسجيل',
                        formCenter: false,
                        children: [
                          _sizeBetween,
                          _buildImageUser(),
                          _sizeBetween,
                          _buildLevelsList,
                          _sizeBetween,
                          CustomTextField(
                            formControlName: 'name',
                            hintText: 'الاسم',
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
                            formControlName: 'password',
                            hintText: 'كلمة المرور',
                            prefixIcon: Icons.vpn_key_rounded,
                            obscureText: true,
                            validationMessages: (control) => {
                              ...validatorRequiredMs,
                              ValidationMessage.minLength:
                                  'كملة المرور يجب ان لا تقل عن 6 احرف '
                            },
                          ),
                          _sizeBetween,
                          CustomTextField(
                            formControlName: 'confirmPassword',
                            hintText: ' تأكيد كلمة المرور',
                            prefixIcon: Icons.vpn_key_rounded,
                            obscureText: true,
                            validationMessages: (control) => {
                              ...validatorRequiredMs,
                              ValidationMessage.mustMatch:
                                  'كلمة المرور غير متطابقة '
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
                          controller.isBusy
                              ? Loading()
                              : CustomSubmitButton(
                                  label: "تسجيل",
                                  onPressed: () => controller.signUp(),
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
        ));
      },
    );
  }

  get _sizeBetween => SizedBox(
        height: 20,
      );

  get _buildLevelsList {
    return Visibility(
      visible: this.typeUser == UserType.Teacher.index,
      child: ListDropdown(
        formControlName: 'level',
        lable: 'المستوى الدراسي',
        values: levels,
      ),
    );
  }

  _buildImageUser() {
    File imageFile;
    SignUpController controller = Get.find<SignUpController>();

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
