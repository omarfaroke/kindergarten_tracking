import 'package:flutter/material.dart';
import 'package:food_preservation/models/message.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/ui/theme/app_colors.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'components/card_info_message.dart';
import 'list_messgae_controller.dart';
import '../../../util/extensions.dart';

class ListMessagePage extends StatelessWidget {
  const ListMessagePage({
    Key key,
    this.titleAppBar,
    this.conversation,
  }) : super(key: key);

  final String titleAppBar;
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ListMessageController>(
        init: ListMessageController(conversation),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title:
                      titleAppBar != null ? Text(titleAppBar) : Text('الرسائل'),
                  centerTitle: true,
                ),
                body: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: controller.loading
                              ? Loading()
                              : GestureDetector(
                                  onTap: () => FocusScope.of(context).unfocus(),
                                  child: (controller.listModel?.isEmpty ?? true)
                                      ? empty()
                                      : list(),
                                ),
                        ),
                        SizedBox(height: 15,),
                        _buildMessageComposer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget list() {
    final controller = Get.find<ListMessageController>();
    final list = controller.listModel;
    return GroupedListView<MessageModel, DateTime>(
        reverse: true,
        groupSeparatorBuilder: (DateTime groupByValue) => Card(
              //  padding: const EdgeInsets.all(8.0),
              color: AppColors.lightPrimary,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  groupByValue.formatDate(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        groupBy: (item) => item.createAt.justDateFromMS,
        itemComparator: (item1, item2) =>
            item2.createAt.compareTo(item1.createAt),
        groupComparator: (item1, item2) => item2.compareTo(item1),
        useStickyGroupSeparators: true, // optional
        floatingHeader: true, // optional
        order: GroupedListOrder.ASC, // optional
        elements: list,
        itemBuilder: (context, item) {
          return CardInfoMessage(
            fromMe: controller.thisMsgFromMe(item),
            message: item,
          );
        });
  }

  _buildMessageComposer() {
    final controller = Get.find<ListMessageController>();
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 8.0),
      // 
      margin: EdgeInsets.all(8.0),
      height: 60.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ReactiveFormBuilder(
              form: () => controller.form,
              builder: (context, form, child) {
                return CustomTextField(
                  formControlName: 'message',
                  hintText: "ارسال رسالة.....",
                  validationMessages: (control) => {...validatorRequiredMs},
                  showErrors: false,
                  maxLines: 1,
                  minLines: 1,
                  suffix: ReactiveStatusListenableBuilder(
                      formControlName: 'message',
                      builder: (context, form, child) {
                        return controller.isBusy
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 25.0,
                                  width: 25.0,
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue)),
                                ),
                              )
                            : IconButton(
                                icon: Icon(Icons.send),
                                iconSize: 25.0,
                                color: AppColors.lightPrimary,
                                onPressed: () {
                                  controller.sendMessage;
                                },
                              );
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget empty() {
    return Center(
      child: Text(
        ' لا يوجد رسائل بعد ...',
        style: TextStyle(
            fontSize: 18,
            color: AppColors.lightPrimary,
            fontFamily: "DinNextLtW23",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
