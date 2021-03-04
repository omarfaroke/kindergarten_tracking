import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String latLngToString(LatLng location) {
  if (location == null) {
    return null;
  }

  String lat = location.latitude.toString();
  String lng = location.longitude.toString();

  String strLocation = lat + ',' + lng;

  return strLocation;
}
