import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final levels = {
  '1': 'المستوى الاول',
  '2': 'المستوى الثاني',
  '3': 'المستوى الثالث',
};

final listBehaviorName = {
  '1': 'جيد',
  '2': 'عادي',
  '3': 'سيء',
};

final listBehaviorIcons = {
  listBehaviorName['1']: FaIcon(
    FontAwesomeIcons.smile,
    color: Colors.green,
  ),
  listBehaviorName['2']: FaIcon(
    FontAwesomeIcons.meh,
    color: Colors.yellow,
  ),
  listBehaviorName['3']: FaIcon(
    FontAwesomeIcons.frown,
    color: Colors.red,
  ),
};

final listSex = {
  '1': 'ذكر',
  '2': 'انثى',
};

final String updatedAtKey = 'updatedAt';

final Map<String, dynamic> updatedAtField = {
  updatedAtKey: FieldValue.serverTimestamp()
};
