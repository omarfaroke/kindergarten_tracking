import 'dart:io';

import 'package:food_preservation/models/cache_files_model.dart';
import 'package:food_preservation/models/table.dart';
import 'package:food_preservation/services/cache_files_service.dart';
import 'package:food_preservation/services/db/table_firestore_service.dart';
import 'package:food_preservation/ui/pages/admin_pages/add_table/add_table_page.dart';
import 'package:food_preservation/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart' as open_file;

class TablesManagementController extends GetxController {
  Rx<List<TableModel>> listTable = new Rx<List<TableModel>>();

  List<TableModel> get tables => listTable.value;

  get addTable {
    Get.to(AddTablePage());
  }

  var _loading = true.obs;
  bool get loading => _loading.value;

  @override
  void onInit() async {
    listTable.bindStream(Get.find<TableFirestoreService>().tablesStream());

    await Get.find<CacheFilesService>().init();

    super.onInit();

    listTable.listen((listData) {
      _loading.value = false;
      // update();
    });
  }

  onPressDelete(TableModel table) async {
    bool ok = await defaultDialog(
      title: 'حذف الجدول',
      middleText: 'هل تريد حذف هذا الجدول ؟',
    );

    if (ok) {
      await Get.find<TableFirestoreService>().deleteTable(table);
      showTextSuccess('تم الحذف بنجاح');
      // update();
    }
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
