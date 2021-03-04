import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:food_preservation/models/app_setting.dart';
import 'package:food_preservation/models/user_model.dart';
import 'package:food_preservation/services/authentication_service.dart';
import 'package:get/get.dart';
import 'db/db_box_model.dart';
import 'db/hive_db_helper.dart';

class AppService {
  AppSetting _appSetting;
  DbBoxModel<AppSetting> dbBox;

  Future init() async {
    //
    await Firebase.initializeApp();

    //
    await HiveDbHelper().init();

    _appSetting = AppSetting();
    dbBox = DbBoxModel<AppSetting>(_appSetting);

    await dbBox.init(modelForstudy: false);
    _appSetting = dbBox.getDataModel();

    if (_appSetting == null) {
      _initFirstTimeRunApp();
    }
  }

  _initFirstTimeRunApp() {
    _appSetting = AppSetting(showScreenInfoEnter: true);

    refreshDb;
  }

  get hideScreenInfoEnter => _appSetting.showScreenInfoEnter = false;

  bool get isUserRegistered => _appSetting.currentUser != null;

  refreshUserInfo(UserModel user) {
    _appSetting.currentUser = user;

    refreshDb;
  }

  get refreshDb async => await dbBox.setData(model: _appSetting);

  Future exitFromApp() async {
    await Future.delayed(Duration(milliseconds: 200));

    SystemNavigator.pop();
  }
}
