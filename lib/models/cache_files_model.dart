import 'dart:convert';

import 'data_model.dart';

class CacheFilesModel extends DataModel {
  String id;
  String nameFile;
  String url;
  String localPath;
  CacheFilesModel({
    this.id,
    this.nameFile,
    this.url,
    this.localPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameFile': nameFile,
      'url': url,
      'localPath': localPath,
    };
  }

  factory CacheFilesModel.fromMap(Map<String, dynamic> map) {
    return CacheFilesModel(
      id: map['id'],
      nameFile: map['nameFile'],
      url: map['url'],
      localPath: map['localPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheFilesModel.fromJson(String source) =>
      source == null ? null : CacheFilesModel.fromMap(json.decode(source));

  @override
  fromJson(String source) => CacheFilesModel.fromJson(source);

  @override
  String get modelName => 'CacheFilesModel';
}
