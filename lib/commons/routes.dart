import 'package:airbnb_clone/views/pages/Home.dart';
import 'package:airbnb_clone/views/pages/HomeScreen.dart';
import 'package:airbnb_clone/views/pages/login.dart';
import 'package:get/get_navigation/get_navigation.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(
          name: '/home',
          page: () => HomePage()
      ),
      GetPage(
          name: '/home_screen',
          page: () => HomeScreen()
      )
    ];
