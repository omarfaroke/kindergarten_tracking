import 'dart:convert';

import 'data_model.dart';
import 'user_model.dart';

class AppSetting extends DataModel {
  UserModel currentUser;
  bool showScreenInfoEnter;
  AppSetting({
    this.currentUser,
    this.showScreenInfoEnter,
  });

  @override
  fromJson(String source) => AppSetting.fromJson(source);

  @override
  String get modelName => 'AppSetting';

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'currentUser': currentUser?.toMap(),
      'showScreenInfoEnter': showScreenInfoEnter,
    };
  }

  factory AppSetting.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppSetting(
      currentUser: UserModel.fromMap(map['currentUser']),
      showScreenInfoEnter: map['showScreenInfoEnter'],
    );
  }

  factory AppSetting.fromJson(String source) =>
      source == null ? null : AppSetting.fromMap(json.decode(source));
}
