import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ParseDateTimeToString on DateTime {
  String formatDate() {
    final DateFormat format = DateFormat.yMd();
    return format.format(this);
  }
}
