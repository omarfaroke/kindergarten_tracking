import 'package:flutter/material.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';

import 'ads_management_controller.dart';
import '../../../widgets/card_info_ads.dart';

class AdsManagementPage extends StatelessWidget {
  const AdsManagementPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<AdsManagementController>(
        init: AdsManagementController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('ادارة الاعلانات'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.add), onPressed: () => controller.add)
                  ],
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.loading
                          ? Loading()
                          : (controller.listModel?.isEmpty ?? true)
                              ? empty()
                              : list(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget list() {
    final controller = Get.find<AdsManagementController>();
    final list = controller.listModel;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoAds(
              ads: list[index],
              onPressDelete: (student) => controller.delete(student),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الاعلانات فارغة ..',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
