import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';

String latLngToString(LatLng location) {
  if (location == null) {
    return null;
  }

  String lat = location.latitude.toString();
  String lng = location.longitude.toString();

  String strLocation = lat + ',' + lng;

  return strLocation;
}

String formatBytes(bytes, decimals) {
  if (bytes == 0) return '0.0';
  var k = 1024,
      dm = decimals <= 0 ? 0 : decimals,
      sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
      i = (log(bytes) / log(k)).floor();
  return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
}

Future<String> get pathApp async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;

  return path;
}
