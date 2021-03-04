import 'dart:convert';

abstract class DataModel {
  String get modelName;

  String toJson();
  dynamic fromJson(String source);
  Map<String, dynamic> toMap();
}
