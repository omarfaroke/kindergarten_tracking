import 'package:flutter/material.dart';
import 'package:food_preservation/models/duties.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'components/card_info_duties.dart';
import 'list_duties_controller.dart';
import '../../../util/extensions.dart';

class ListDutiesPage extends StatelessWidget {
  const ListDutiesPage({
    Key key,
    @required this.level,
    this.titleAppBar,
    this.forParent = false,
  }) : super(key: key);

  final List<String> level;
  final String titleAppBar;
  final bool forParent;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListDutiesController>(
        init: ListDutiesController(level),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: titleAppBar != null
                      ? Text(titleAppBar)
                      : Text('الواجبات'),
                  centerTitle: true,
                  actions: [
                    !forParent
                        ? IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => controller.add)
                        : SizedBox(),
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
    final controller = Get.find<ListDutiesController>();
    final list = controller.listModel;
    return Expanded(
      child: GroupedListView<Duties, String>(
          groupSeparatorBuilder: (String groupByValue) =>
              Card(
              //  padding: const EdgeInsets.all(8.0),
              color: AppColors.lightPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(groupByValue ?? '' , style: TextStyle(color: Colors.white),),
                ),
              ),
          groupBy: (item) => item.date.formatDate(),
          itemComparator: (item1, item2) => item1.date.compareTo(item2.date),
          groupComparator: (item1, item2) => item1.length.compareTo(item2.length),
          useStickyGroupSeparators: true, // optional
          floatingHeader: true, // optional
          order: GroupedListOrder.ASC, // optional
          elements: list,
          itemBuilder: (context, item) {
            return CardDutiesInfo(
              duties: item,
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الواجبات فارغة !',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
