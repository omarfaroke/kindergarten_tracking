import 'dart:convert';
import 'data_model.dart';

class Ads extends DataModel {
  String id;
  String title;
  String text;
  String photo;
  int date;
  Ads({
    this.id,
    this.title,
    this.text,
    this.photo,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'photo': photo,
      'date': date,
    };
  }

  factory Ads.fromMap(Map<String, dynamic> map) {
    return Ads(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      photo: map['photo'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ads.fromJson(String source) => Ads.fromMap(json.decode(source));

  @override
  fromJson(String source) => Ads.fromJson(source);

  @override
  String get modelName => 'ads';
}
