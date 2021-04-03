import 'package:flutter/material.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'components/card_info_parent.dart';
import 'parents_management_controller.dart';

class ParentsManagementPage extends StatelessWidget {
  const ParentsManagementPage({Key key, this.showSelected = false})
      : super(key: key);

  final bool showSelected;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ParentsManagementController>(
        init: ParentsManagementController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: showSelected
                      ? Text(' اولياء الامور')
                      : Text('ادارة اولياء الامور'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.person_add),
                        onPressed: () => controller.add)
                  ],
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.loading
                          ? Loading()
                          : (controller.listParents.value?.isEmpty ?? true)
                              ? empty()
                              : listParents(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listParents() {
    final controller = Get.find<ParentsManagementController>();
    final list = controller.listParents.value;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoParent(
              parent: list[index],
              onPressDelete: (parent) => controller.delete(parent),
              onPressEdit: (parent) => controller.edit(parent),
              onStatusChanged: (parent, status) =>
                  controller.changeStatus(parent, status),
              onPressSelected:
                  showSelected ? (parent) => controller.selected(parent) : null,
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة اولياء الامور فارغة ..',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
