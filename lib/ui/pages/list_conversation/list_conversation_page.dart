import 'package:flutter/material.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';

import 'components/card_info_conversation.dart';
import 'list_conversation_controller.dart';

class ListConversationPage extends StatelessWidget {
  const ListConversationPage({
    Key key,
    this.titleAppBar,
  }) : super(key: key);

  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListConversationController>(
        init: ListConversationController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title:
                      titleAppBar != null ? Text(titleAppBar) : Text('الرسائل'),
                  centerTitle: true,
                  actions: [
                    controller.isParent
                        ? IconButton(
                            icon: Icon(Icons.add_comment_sharp),
                            onPressed: () => controller.add)
                        : SizedBox()
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
                              : listStudents(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget listStudents() {
    final controller = Get.find<ListConversationController>();
    final list = controller.listModel;
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardInfoConversation(
              forParent: controller.isParent,
              conversation: list[index],
              onSelected: (conversation) => controller.onSelected(conversation),
            );
          }),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        'قائمة الرسائل فارغة',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
