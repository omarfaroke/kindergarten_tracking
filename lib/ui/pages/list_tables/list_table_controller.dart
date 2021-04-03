import 'dart:io';

import 'package:food_preservation/models/cache_files_model.dart';
import 'package:food_preservation/models/table.dart';
import 'package:food_preservation/services/cache_files_service.dart';
import 'package:food_preservation/services/db/table_firestore_service.dart';
import 'package:food_preservation/ui/widgets/toast_msg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart' as open_file;

class ListTableController extends GetxController {
  Rx<List<TableModel>> list = new Rx<List<TableModel>>();

  List<String> _level;

  ListTableController(List<String> level) {
    _level = level;
  }

  List<TableModel> get listModel {
    return list.value
        .where((element) => _level.contains(element.level))
        .toList();
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() async {
    list.bindStream(Get.find<TableFirestoreService>().tablesStream());
    await Get.find<CacheFilesService>().init();
    super.onInit();
    list.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

  onPressDownload(TableModel table) async {
    bool ok = await defaultDialog(
      title: 'تحميل ملف الجدول',
      middleText: 'هل تريد تحميل ملف هذا الجدول ؟',
    );

    if (!ok) {
      return;
    }

    String _path = await dialogDownload(url: table.pathFile);

    if (_path == null) {
      showTextError('فشل التحميل !');
      return;
    }

    File file = File(_path);

    open_file.OpenFile.open(file.path);

    CacheFilesModel info =
        CacheFilesModel(localPath: _path, url: table.pathFile);

    await Get.find<CacheFilesService>().addInfoFile(info);

    update();
  }

  onPressOpen(TableModel table) async {
    String path =
        Get.find<CacheFilesService>().getPathLocalFile(table.pathFile);

    File file = File(path);

    if (!await file.exists()) {
      await Get.find<CacheFilesService>().removeInfoFile(path);
      showTextError('الملف غير موجود! , قم بتحمبله من جديد');
      update();
      return;
    }

    open_file.OpenFile.open(file.path);
  }

  bool isTableFileExist(TableModel table) {
    bool exists =
        Get.find<CacheFilesService>().checkFileIsExists(table.pathFile);

    return exists;
  }
}
