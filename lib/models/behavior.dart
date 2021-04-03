import 'dart:convert';
import 'data_model.dart';

class Behavior extends DataModel {
  String id;
  String behavior;
  int date;
  String studentId;
  Behavior({
    this.id,
    this.behavior,
    this.date,
    this.studentId,
  });

  @override
  fromJson(String source) => Behavior.fromJson(source);

  @override
  String get modelName => 'Behavior';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'behavior': behavior,
      'date': date,
      'studentId': studentId,
    };
  }

  factory Behavior.fromMap(Map<String, dynamic> map) {
    return Behavior(
      id: map['id'],
      behavior: map['behavior'],
      date: map['date'],
      studentId: map['studentId'],
    );
  }

  factory Behavior.fromJson(String source) =>
      source == null ? null : Behavior.fromMap(json.decode(source));
}
