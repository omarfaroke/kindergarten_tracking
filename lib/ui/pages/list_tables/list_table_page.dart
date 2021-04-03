import 'package:flutter/material.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'components/card_info_table.dart';
import 'list_table_controller.dart';

class ListTablePage extends StatelessWidget {
  const ListTablePage({
    Key key,
    @required this.level,
    this.titleAppBar, 
  }) : super(key: key);

  final List<String> level;
  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListTableController>(
        init: ListTableController(level ),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: titleAppBar != null
                      ? Text(titleAppBar)
                      : Text('جداول الحصص'),
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
                          : listTable(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listTable() {
    final controller = Get.find<ListTableController>();
    final list = controller.listModel;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardTableInfo(
              table: list[index],
              onPressOpen: (table) => controller.onPressOpen(table),
              onPressDownload: (table) => controller.onPressDownload(table),
              isExists:controller.isTableFileExist(list[index]),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الجداول فارغة !',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
