import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_preservation/constants/constants.dart';
import 'package:food_preservation/models/message.dart';
import 'package:food_preservation/services/db/user_firestore_service.dart';
import 'package:get/get.dart';

class MessageFirestoreService extends GetxService {
  final CollectionReference _messageCollectionReference =
      FirebaseFirestore.instance.collection('message');
  final CollectionReference _conversationCollectionReference =
      FirebaseFirestore.instance.collection('conversation');

  Future<bool> createMessage(
    MessageModel message,
  ) async {
    DocumentReference doc = await _messageCollectionReference.add({});
    message.id = doc.id;
    message.createAt = DateTime.now().millisecondsSinceEpoch;
    await _messageCollectionReference.doc(message.id).set(message.toMap());
    return true;
  }

  Stream<List<MessageModel>> messagesStream(String conversationId) {
    return _messageCollectionReference
        .where('conversationId', isEqualTo: conversationId)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<MessageModel> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(MessageModel.fromMap(mapData));
      });
      return retVal;
    });
  }

  Future<Conversation> createConversation(
    Conversation conversation,
  ) async {
    DocumentReference doc = await _conversationCollectionReference.add({});
    conversation.id = doc.id;
    conversation.createAt = DateTime.now().millisecondsSinceEpoch;
    conversation.updatedAt = conversation.createAt;

    await _conversationCollectionReference
        .doc(conversation.id)
        .set(conversation.toMap());
    return conversation;
  }

  Stream<List<Conversation>> conversationStream(
      {String userId, bool forParent = true}) {
    String feildKey = 'user1'; //parent
    if (!forParent) {
      feildKey = 'user2'; // teacher
    }
    return _conversationCollectionReference
        .where(feildKey, isEqualTo: userId)
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot query) {
      List<Conversation> retVal = List();
      query.docs.forEach((element) {
        Map mapData = element.data();
        mapData['id'] = element.id;
        retVal.add(Conversation.fromMap(mapData));
      });
      retVal.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));

      return retVal;
    });
  }
}
