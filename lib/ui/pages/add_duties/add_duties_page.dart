import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'add_duties_controller.dart';

class AddDutiesPage extends StatelessWidget {
  const AddDutiesPage({
    Key key,
    @required this.level,
  }) : super(key: key);

  final String level;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDutiesController>(
      init: AddDutiesController(level),
      builder: (controller) => SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('إضافة واجب'),
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
                    ListDropdown(
                      formControlName: 'level',
                      lable: 'المستوى الدراسي',
                      values: levels,
                      readOnly: true,
                    ),
                    _sizeBetween,
                    CustomTextField(
                      formControlName: 'text',
                      hintText: 'الواجب',
                      prefixIcon: Icons.perm_identity,
                      validationMessages: (control) => {...validatorRequiredMs},
                      onSubmitted: () => form.focus(''),
                      minLines: 2,
                      maxLines: 3,
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
}
