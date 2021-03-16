import 'dart:convert';

import 'package:food_preservation/models/data_model.dart';
import 'package:food_preservation/models/user_model.dart';

class Teacher extends DataModel {
  UserModel info;
  String level;
  Teacher({
    this.info,
    this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'info': info.toMap(),
      'level': level,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      info: UserModel.fromMap(map['info']),
      level: map['level'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      source == null ? null : Teacher.fromMap(json.decode(source));

  @override
  fromJson(String source) => Teacher.fromJson(source);

  @override
  String get modelName => 'teacher';
}

class TeacherLevel {
  String level;
  String teacherId;
  TeacherLevel({
    this.level,
    this.teacherId,
  });

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'teacherId': teacherId,
    };
  }

  factory TeacherLevel.fromMap(Map<String, dynamic> map) {
    return TeacherLevel(
      level: map['level'],
      teacherId: map['teacherId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherLevel.fromJson(String source) =>
      source == null ? null : TeacherLevel.fromMap(json.decode(source));
}
