import 'package:food_preservation/models/cache_files_model.dart';
import 'package:get/get.dart';

import 'db/db_box_model.dart';

class CacheFilesService extends GetxService {
  List<CacheFilesModel> _listModel;
  DbBoxModel<CacheFilesModel> dbBox;

  Future init() async {
    //
    _listModel = List();
    dbBox = DbBoxModel<CacheFilesModel>(CacheFilesModel());

    await dbBox.init();
    _listModel = dbBox.getAllDataModelsInBox();
  }

  bool checkFileIsExists(String url) {
    if (_listModel == null) {
      return false;
    }
    CacheFilesModel info = _listModel
        .firstWhere((element) => element.url == url.trim(), orElse: () => null);

    if (info == null) {
      return false;
    }

    return true;
  }

  String getPathLocalFile(String url) {
    CacheFilesModel info = _listModel
        .firstWhere((element) => element.url == url.trim(), orElse: () => null);

    if (info == null) {
      return null;
    }

    return info.localPath;
  }

  Future addInfoFile(CacheFilesModel info) async {
    _listModel.add(info);

    await refreshDb;
  }

  Future removeInfoFile(String path) async {
    _listModel.removeWhere((element) => element.localPath == path.trim());
    await refreshDb;
  }

  get refreshDb async => _listModel.forEach((model) {
        dbBox.setData(key: model.url, model: model);
      });
}
