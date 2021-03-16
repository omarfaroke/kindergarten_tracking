import 'dart:convert';
import 'package:food_preservation/models/student.dart';
import 'data_model.dart';
import 'user_model.dart';


class Levels extends DataModel {
  String number;
  List<UserModel> teachers;
  List<Student> students;
  Levels({
    this.number,
    this.teachers,
    this.students,
  });

  @override
  fromJson(String source) => Levels.fromJson(source);

  @override
  String get modelName => 'Levels';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'teachers': teachers?.map((x) => x.toMap())?.toList(),
      'students': students?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Levels.fromMap(Map<String, dynamic> map) {
    return Levels(
      number: map['number'],
      teachers: List<UserModel>.from(
          map['teachers']?.map((x) => UserModel.fromMap(x))),
      students:
          List<Student>.from(map['students']?.map((x) => Student.fromMap(x))),
    );
  }

  factory Levels.fromJson(String source) => Levels.fromMap(json.decode(source));
}
