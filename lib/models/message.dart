import 'dart:convert';

import 'package:food_preservation/models/user_model.dart';

import 'data_model.dart';

class MessageModel extends DataModel {
  String id;
  String message;
  String conversationId;
  String senderId;
  int createAt;
  MessageModel({
    this.id,
    this.message,
    this.conversationId,
    this.senderId,
    this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'conversationId': conversationId,
      'senderId': senderId,
      'createAt': createAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      message: map['message'],
      conversationId: map['conversationId'],
      senderId: map['senderId'],
      createAt: map['createAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      source == null ? null : MessageModel.fromMap(json.decode(source));

  @override
  fromJson(String source) => MessageModel.fromJson(source);

  @override
  String get modelName => 'MessageModel';
}

class Conversation extends DataModel {
  String id;
  String senderId;
  String user1;
  String user2;
  String lastMessage;
  int updatedAt;
  int createAt;
  String status;
  UserModel userModel1;
  UserModel userModel2;
  Conversation({
    this.id,
    this.senderId,
    this.user1,
    this.user2,
    this.lastMessage,
    this.updatedAt,
    this.createAt,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'user1': user1,
      'user2': user2,
      'lastMessage': lastMessage,
      'updatedAt': updatedAt,
      'createAt': createAt,
      'status': status,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'],
      senderId: map['senderId'],
      user1: map['user1'],
      user2: map['user2'],
      lastMessage: map['lastMessage'],
      updatedAt: map['updatedAt'],
      createAt: map['createAt'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source));

  @override
  fromJson(String source) => Conversation.fromJson(source);

  @override
  String get modelName => 'Conversation';
}
