import 'dart:convert';

import 'data_model.dart';

class FollowExit extends DataModel {
  String id;
  String timeExit;
  int date;
  String studentId;
  FollowExit({
    this.id,
    this.timeExit ,
    this.date,
    this.studentId,
  });

  @override
  fromJson(String source) => FollowExit.fromJson(source);

  @override
  String get modelName => 'FollowExit';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timeExit': timeExit,
      'date': date,
      'studentId': studentId,
    };
  }

  factory FollowExit.fromMap(Map<String, dynamic> map) {
    return FollowExit(
      id: map['id'],
      timeExit: map['timeExit'],
      date: map['date'],
      studentId: map['studentId'],
    );
  }

  factory FollowExit.fromJson(String source) =>
      source == null ? null : FollowExit.fromMap(json.decode(source));
}
