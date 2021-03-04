import 'package:flutter/material.dart';
import 'package:food_preservation/services/authentication_service.dart';
import 'package:food_preservation/ui/widgets/drawer_app.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                drawer: AppDrawer(),
                appBar: AppBar(
                  title: Text('الرئيسية'),
                  centerTitle: true,
                ),
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'مرحباً ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                          Get.find<AuthenticationService>().currentUser.email ??
                              'null'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
