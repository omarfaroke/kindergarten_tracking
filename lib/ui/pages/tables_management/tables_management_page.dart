import 'package:flutter/material.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/table.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/card_info_teacher.dart';
import 'package:get/get.dart';
import 'tables_management_controller.dart';
import '../../../util/extensions.dart';

class TablesManagementPage extends StatelessWidget {
  const TablesManagementPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TablesManagementController>(
        init: TablesManagementController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('ادارة جداول الحصص'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.add_chart),
                        onPressed: () => controller.addTable)
                  ],
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),
                      (controller.listTable.value?.isEmpty ?? true)
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
    final controller = Get.find<TablesManagementController>();
    final list = controller.listTable.value;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardTableInfo(
              table: list[index],
              onPressDelete: (table) => controller.onPressDelete(table),
              onPressDownload: (table) => controller.onPressDownload(table),
              onPressOpen: (table) => controller.onPressOpen(table),
              isExists: controller.isTableFileExist(list[index]),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الجداول فارغة ..',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CardTableInfo extends StatelessWidget {
  const CardTableInfo({
    Key key,
    this.table,
    this.onPressDelete,
    this.onPressDownload,
    this.isExists = false,
    this.onPressOpen,
  }) : super(key: key);

  final TableModel table;
  final Function(TableModel) onPressDelete;
  final Function(TableModel) onPressDownload;
  final Function(TableModel) onPressOpen;
  final bool isExists;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    'جدول  : ${levels[table.level]}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                  subtitle: Text(
                    'تاريخ الإضافة : ${table.createDate.formatDate()}',
                    style: TextStyle(
                      fontFamily: "DinNextLtW23",
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () => onPressDelete(table),
                    icon: Icon(Icons.delete),
                    label: Text('حذف الجدول'),
                  ),
                  isExists
                      ? TextButton.icon(
                          onPressed: () => onPressOpen(table),
                          icon: Icon(Icons.open_in_new),
                          label: Text('فتح'),
                        )
                      : TextButton.icon(
                          onPressed: () => onPressDownload(table),
                          icon: Icon(Icons.file_download),
                          label: Text('تحميل'),
                        ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
