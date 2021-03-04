import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BaseDbBox {
  String _boxName;
  Box<dynamic> _box;
  String _firstElmentKey = 0.toString();

  Future init(String boxName) async {
    _boxName = boxName;

    _box = await Hive.openBox(_boxName);
  }

  List getAllDataModelsInBox() {
    List<dynamic> listData = _box.values.toList();

    return listData;
  }

  getData({String key, dynamic defaultValue}) {
    final data = _box.get(key ?? _firstElmentKey, defaultValue: defaultValue);
    return data;
  }

  Future<void> setData({String key, @required dynamic data}) async {
    await _box.put(key ?? _firstElmentKey, data);
  }

  Future closeBox() async {
    await _box.close();
  }
}
