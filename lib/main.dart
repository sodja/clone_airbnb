import 'package:airbnb_clone/views/pages/login.dart';
import 'package:country_codes/country_codes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'commons/routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CountryCodes.init();
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
    initialRoute: '/loading',
    getPages: appRoutes(),
    enableLog: true,
    defaultTransition: Transition.fade,
    opaqueRoute: Get.isOpaqueRouteDefault,
    popGesture: Get.isPopGestureEnable,
  ));
}
