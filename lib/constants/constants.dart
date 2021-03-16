import 'package:cloud_firestore/cloud_firestore.dart';

final levels = {
  '1': 'المستوى الاول',
  '2': 'المستوى الثاني',
  '3': 'المستوى الثالث',
};

final String updatedAtKey = 'updatedAt';

final Map<String,dynamic> updatedAtField = {updatedAtKey: FieldValue.serverTimestamp()};
