import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'add_ads_controller.dart';

class AddAdsPage extends StatelessWidget {
  const AddAdsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAdsController>(
      init: AddAdsController(),
      builder: (controller) => SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('إضافة إعلان'),
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
                    // _buildImage(),
                    // _sizeBetween,
                    // CustomTextField(
                    //   formControlName: 'title',
                    //   hintText: 'عنوان الاعلان',
                    //   prefixIcon: Icons.title,
                    //   validationMessages: (control) => {...validatorRequiredMs},
                    //   onSubmitted: () => form.focus('text'),
                    // ),
                    _sizeBetween,
                    CustomTextField(
                      formControlName: 'text',
                      hintText: ' نص الاعلان',
                      prefixIcon: Icons.text_fields,
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
        ),
      )),
    );
  }

  get _sizeBetween => SizedBox(
        height: 20,
      );

  _buildImage() {
    File imageFile;
    AddAdsController controller = Get.find<AddAdsController>();

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
