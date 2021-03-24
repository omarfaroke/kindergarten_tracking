import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/pick_Image_and_crop.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_widgets/reactive_forms_widgets.dart';
import 'add_table_controller.dart';

class AddTablePage extends StatelessWidget {
  const AddTablePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTableController>(
      init: AddTableController(),
      builder: (controller) => SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('إضافة جدول'),
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
                    ),
                    _sizeBetween,
                    ReactiveDateTimePicker(
                      formControlName: 'createDate',
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      decoration: const InputDecoration(
                        labelText: 'تاريخ الإضافة',
                        border: OutlineInputBorder(),
                        helperText: '',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    _sizeBetween,
                    CustomTextField(
                      formControlName: 'pathFile',
                      hintText: ' مسار ملف الجدول',
                      prefixIcon: Icons.file_copy,
                      validationMessages: (control) => {
                        ...validatorRequiredMs,
                      },
                      readOnly: true,
                      minLines: 2,
                      maxLines: 4,
                    ),
                    _sizeBetween,
                    ReactiveValueListenableBuilder(
                        formControlName: 'pathFile',
                        builder: (context, formControl, child) {
                          return ElevatedButton(
                            child: Text(
                              formControl.value == null
                                  ? 'اختيار ملف الجدول'
                                  : 'استبدال ملف الجدول',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.lightTextButton,
                                  fontFamily: "DinNextLtW23",
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => controller.pickPdfFile,
                            clipBehavior: Clip.antiAlias,
                          );
                        }),
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
