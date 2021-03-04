import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/locator.dart';
import 'services/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await locator<AppService>().init();

  // await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(App());
}


