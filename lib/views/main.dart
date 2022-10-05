import 'package:airbnb_clone/views/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commons/routes.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Airbnb',
    debugShowCheckedModeBanner: false,
    locale: const Locale('fr', 'FR'),
    home : LoginPage(),
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.white
        ),
        fontFamily: 'Poppins'
    ),
    initialRoute: '/home',
    getPages: appRoutes(),
    enableLog: true,
    defaultTransition: Transition.fade,
    opaqueRoute: Get.isOpaqueRouteDefault,
    popGesture: Get.isPopGestureEnable,
  ));
}
