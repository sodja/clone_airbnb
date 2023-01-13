
import 'package:airbnb_clone/views/pages/details_profil.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../views/pages/home.dart';
import '../views/pages/home_screen.dart';
import '../views/pages/messages.dart';
import '../views/pages/profile_page.dart';
import '../views/pages/profile_page.dart';
import '../views/pages/chat.dart';
import '../views/pages/loading.dart';
import '../views/pages/login.dart';
import '../views/pages/maps.dart';
import '../views/pages/otp_inscription.dart';


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
      ),
      GetPage(
          name: '/profile',
          page: () => ProfilePage()
      ),
      GetPage(
          name: '/message',
          page: () => MessagesPage()
      ),
      GetPage(
          name: '/otp',
          page: () => OtpInscriptionPage()
      ),
      GetPage(
          name: '/detail_profil',
          page: () => DetailsProfil()
      ),
      GetPage(
          name: '/map',
          page: () => MapsView()
      ),
      GetPage(
            name: '/loading',
            page: () => LoadingPage(),
      ),
      GetPage(
            name: '/chat',
            page: () => Chat(),
      ),
    ];
