import 'package:flutter/material.dart';
import 'package:food_preservation/ui/animation/fade_animation.dart';
import 'package:food_preservation/ui/pages/signup/sign_up_page.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class TypeSignUpPage extends StatelessWidget {
  const TypeSignUpPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: FadeAnimation(
            0.8,
            TempletForm(
              title: 'تسجيل كـ',
              iconForm: 'assets/images/icon2.png',
              children: [
                Column(
                  children: [
                    FadeAnimation(
                      1,
                      GFButton(
                        text: "معلم",
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "DinNextLtW23",
                        ),
                        icon: Icon(
                          Icons.person,
                          color: AppColors.lightTextButton,
                        ),
                        color: AppColors.lightPrimary,
                        fullWidthButton: true,
                        blockButton: true,
                        size: GFSize.LARGE,
                        shape: GFButtonShape.pills,
                        onPressed: () {
                          Get.off(SignUpPage(typeUser: UserType.Teacher.index));
                        },
                      ),
                    ),
                    _sizeBetween,
                    FadeAnimation(
                      1.3,
                      GFButton(
                        text: "ولي امر",
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "DinNextLtW23",
                        ),
                        icon: Icon(
                          Icons.person,
                          color: AppColors.lightTextButton,
                        ),
                        color: AppColors.lightPrimary,
                        fullWidthButton: true,
                        blockButton: true,
                        size: GFSize.LARGE,
                        shape: GFButtonShape.pills,
                        onPressed: () {
                          Get.off(SignUpPage(typeUser: UserType.Parent.index));
                        },
                      ),
                    ),
                    _sizeBetween,
                  ],
                ),
              ],
            ),
          )),
    ));
  }

  get _sizeBetween => SizedBox(
        height: 20,
      );
}
