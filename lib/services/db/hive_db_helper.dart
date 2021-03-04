import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDbHelper {
  final String _dbAppName = "dbApp";
  Future init() async {
    await Hive.initFlutter(_dbAppName);
  }

  delet() async {
  await  Hive.deleteFromDisk();

  }
}
