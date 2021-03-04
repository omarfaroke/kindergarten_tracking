import 'dart:convert';
import 'package:food_preservation/models/data_model.dart';
import 'package:hive/hive.dart';

class DbBoxModel<T extends DataModel> {
  String _boxName;
  Box<dynamic> _box;
  T _dataModel;
  String _firstElmentKey = 0.toString();

  DbBoxModel(this._dataModel);

  Future init({bool modelForstudy = true}) async {
    _boxName = _dataModel.modelName;

    _box = await Hive.openBox(_boxName);
  }

  List<T> getAllDataModelsInBox({String sortField}) {
    List<dynamic> listData = _box.values.toList();
    List<T> listModel = listData.map<T>((e) {
      return _dataModel.fromJson(e);
    }).toList();

    if (sortField != null) {
      // sort list
      listModel
          .sort((a, b) => b.toMap()[sortField].compareTo(a.toMap()[sortField]));
    }
    return listModel;
  }

  T getDataModel({String key, dynamic defaultValue}) {
    final data = _box.get(key ?? _firstElmentKey, defaultValue: defaultValue);
    return _dataModel.fromJson(data);
  }

  Future<void> setData({String key, T model}) async {
    await _box.put(key ?? _firstElmentKey, model.toJson());
  }

  Future closeBox() async {
    await _box.close();
  }
}
