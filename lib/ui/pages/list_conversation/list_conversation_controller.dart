import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/models/message.dart';
import 'package:food_preservation/models/student.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/db/message_firestore_service.dart';
import 'package:food_preservation/services/db/students_firestore_service.dart';
import 'package:food_preservation/services/db/teacher_firestore_service.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:food_preservation/ui/pages/list_followExit/list_followExit_page.dart';
import 'package:food_preservation/ui/pages/list_messages/list_message_page.dart';
import 'package:food_preservation/ui/pages/list_students/list_students_page.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:food_preservation/util/enums.dart';
import 'package:get/get.dart';

class ListConversationController extends GetxController {
  Rx<List<Conversation>> list = new Rx<List<Conversation>>();

  UserModel get userModel => locator<AppService>().currentUser;

  bool get isParent => userModel.type == UserType.Parent.index;

  List<Conversation> get listModel {
    return list.value.toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  get add async {
    Conversation conversation = new Conversation();

    await Get.to(ListStudentsPage(
      titleAppBar: isParent ? 'مراسلة معلم الطفل' : 'مراسلة ولي امر الطالب',
      parent: isParent ? userModel : null,
      onSelected: (student) async {
        if (isParent) {
          String idTeacher = await Get.find<TeacherFirestoreService>()
              .getFirstTeacherByLevel(student.level);
          if (idTeacher == null) {
            showTextError('لا يوجد معلم لهذا المستوى !');
            return;
          }
          conversation.user1 = userModel.id;
          conversation.user2 = idTeacher;
        } else {
          conversation.user1 = student.parentId;
          conversation.user2 = userModel.id;
        }

        conversation = await Get.find<MessageFirestoreService>()
            .createConversation(conversation);

        onSelected(conversation);
      },
    ));
  }

  @override
  void onInit() {
    list.bindStream(Get.find<MessageFirestoreService>().conversationStream());
    super.onInit();
    list.listen((listData) {
      setUpConversation;
      // update();
    });
  }

  onSelected(Conversation conversation) async {
    Get.to(ListMessagePage(
      conversation: conversation,
    ));
  }

  get setUpConversation async {
    List<String> listUserId = List();

    for (Conversation c in list.value) {
      listUserId.add(c.user1);
      listUserId.add(c.user2);
    }

    if (listUserId.isNotEmpty) {
      listUserId = listUserId.toSet().toList();

      List<UserModel> listUser = await Get.find<UserFirestoreService>()
          .usersFromListId(listId: listUserId);
      if (listUser != null && listUser.isNotEmpty) {
        for (Conversation c in list.value) {
          c.userModel1 = listUser.firstWhere((element) => element.id == c.user1,
              orElse: () => null);
          c.userModel2 = listUser.firstWhere((element) => element.id == c.user2,
              orElse: () => null);
        }
      }
    }

    _loading.value = false;
  }
}
