import 'dart:convert';

import 'data_model.dart';

class Student extends DataModel {
  String id;
  String name;
  String parentId;
  String level;
  Student({
    this.id,
    this.name,
    this.parentId,
    this.level,
  });

  @override
  fromJson(String source) => Student.fromJson(source);

  @override
  String get modelName => 'Student';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'level': level,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
      level: map['level'],
    );
  }

  factory Student.fromJson(String source) =>
      source == null ? null : Student.fromMap(json.decode(source));
}
