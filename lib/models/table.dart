import 'dart:convert';

import 'data_model.dart';

class TableModel extends DataModel {
  String id;
  String level;
  String pathFile;
  DateTime createDate;
  TableModel({
    this.id,
    this.level,
    this.pathFile,
    this.createDate,
  });

  @override
  fromJson(String source) => TableModel.fromJson(source);

  @override
  String get modelName => 'table';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'pathFile': pathFile,
      'createDate': createDate.millisecondsSinceEpoch,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'],
      level: map['level'],
      pathFile: map['pathFile'],
      createDate: map['createDate'] is DateTime ? map['createDate'] : DateTime.fromMillisecondsSinceEpoch(map['createDate']),
    );
  }

  factory TableModel.fromJson(String source) =>
      source == null ? null : TableModel.fromMap(json.decode(source));
}
