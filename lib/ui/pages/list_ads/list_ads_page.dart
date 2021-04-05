import 'package:flutter/material.dart';
import 'package:food_preservation/models/ads.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/card_info_ads.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../../util/extensions.dart';
import 'list_ads_controller.dart';

class ListAdsPage extends StatelessWidget {
  const ListAdsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListAdsController>(
        init: ListAdsController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('الاعلانات'),
                  centerTitle: true,
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
    final controller = Get.find<ListAdsController>();
    final list = controller.listModel;
    return Expanded(
      child: GroupedListView<Ads, String>(
          groupSeparatorBuilder: (String groupByValue) => Card(
                //  padding: const EdgeInsets.all(8.0),
                color: AppColors.lightPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    groupByValue ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          groupBy: (item) => item.date.formatDate(),
          itemComparator: (item1, item2) => item1.date.compareTo(item2.date),
          groupComparator: (item1, item2) =>
              item1.length.compareTo(item2.length),
          useStickyGroupSeparators: true, // optional
          floatingHeader: true, // optional
          order: GroupedListOrder.ASC, // optional
          elements: list,
          itemBuilder: (context, item) {
            return CardInfoAds(
              ads: item,
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الاعلانات فارغة !',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
