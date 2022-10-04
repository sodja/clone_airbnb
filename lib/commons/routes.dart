import 'package:airbnb_clone/views/pages/login.dart';
import 'package:get/get_navigation/get_navigation.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      )
    ];
