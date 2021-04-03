import 'dart:convert';
import 'data_model.dart';

class Duties extends DataModel {
  String id;
  String text;
  int date;
  String level;
  Duties({
    this.id,
    this.text,
    this.date,
    this.level,
  });

  @override
  fromJson(String source) => Duties.fromJson(source);

  @override
  String get modelName => 'Duties';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date,
      'level': level,
    };
  }

  factory Duties.fromMap(Map<String, dynamic> map) {
    return Duties(
      id: map['id'],
      text: map['text'],
      date: map['date'],
      level: map['level'],
    );
  }

  factory Duties.fromJson(String source) =>
      source == null ? null : Duties.fromMap(json.decode(source));
}
