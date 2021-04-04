import 'package:food_preservation/app/locator.dart';
import 'package:food_preservation/models/message.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/app_service.dart';
import 'package:food_preservation/services/db/message_firestore_service.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ListMessageController extends GetxController {
  Rx<List<MessageModel>> list = new Rx<List<MessageModel>>();

  Conversation _conversation;

  ListMessageController(Conversation conversation) {
    _conversation = conversation;
  }

  final _form = fb.group({
    'message': FormControl(
      validators: [
        Validators.required,
      ],
    ),
  }, []);

  FormGroup get form => _form;

  List<MessageModel> get listModel {
    return list.value.toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  bool _messageSending = false;
  bool get messageSending => _messageSending;

  RxBool _isBusy = false.obs;

  bool get isBusy => _isBusy.value;
  set isBusy(bool value) {
    _isBusy.value = value;
  }

  get sendMessage async {
    if (_form.valid) {
      //
      try {
        isBusy = true;

        Map mapFrom = _form.value;

        MessageModel message = MessageModel.fromMap(mapFrom);

        message.conversationId = _conversation.id;

        message.createAt = DateTime.now().millisecondsSinceEpoch;
        message.senderId = locator<AppService>().currentUser.id;

        bool ok =
            await Get.find<MessageFirestoreService>().createMessage(message);

        if (!ok) {
          throw new Exception();
        }
      } catch (e) {
        showTextError("خطأ في ارسال الرسالة");

        isBusy = false;

        return;
      }

      // showTextSuccess('تم إضافة البيانات بنجاح');

      isBusy = false;
      _form.reset();
    } else {
      _form.markAllAsTouched();

      return false;
    }

    return true;
  }

  @override
  void onInit() {
    list.bindStream(
        Get.find<MessageFirestoreService>().messagesStream(_conversation.id));
    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

  bool thisMsgFromMe(MessageModel item) {
   return item.senderId == locator<AppService>().currentUser.id;
  }
}
