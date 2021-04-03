import 'dart:convert';
import 'data_model.dart';

class Student extends DataModel {
  String id;
  String name;
  String address;
  String photo;
  String sex;
  int birthDate;
  String parentId;
  String level;
  String status;
  Student({
    this.id,
    this.name,
    this.address,
    this.photo,
    this.sex,
    this.birthDate,
    this.parentId,
    this.level,
    this.status,
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
      'address': address,
      'photo': photo,
      'sex': sex,
      'birthDate': birthDate,
      'parentId': parentId,
      'level': level,
      'status': status,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      photo: map['photo'],
      sex: map['sex'],
      birthDate: map['birthDate'],
      parentId: map['parentId'],
      level: map['level'],
      status: map['status'],
    );
  }

  factory Student.fromJson(String source) =>
      source == null ? null : Student.fromMap(json.decode(source));
}
