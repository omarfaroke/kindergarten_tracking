import 'dart:convert';

import 'behavior.dart';
import 'data_model.dart';
import 'follow_exit.dart';
import 'student.dart';

class InfoClassStudent extends DataModel {
  Student student;
  Behavior behavior;
  FollowExit followExit;
  InfoClassStudent({
    this.student,
    this.behavior,
    this.followExit,
  });

  @override
  fromJson(String source) => InfoClassStudent.fromJson(source);

  @override
  String get modelName => 'InfoClassStudent';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'student': student.toMap(),
      'behavior': behavior.toMap(),
      'followExit': followExit.toMap(),
    };
  }

  factory InfoClassStudent.fromMap(Map<String, dynamic> map) {
    return InfoClassStudent(
      student: Student.fromMap(map['student']),
      behavior: Behavior.fromMap(map['behavior']),
      followExit: FollowExit.fromMap(map['followExit']),
    );
  }

  factory InfoClassStudent.fromJson(String source) =>
      source == null ? null : InfoClassStudent.fromMap(json.decode(source));
}
