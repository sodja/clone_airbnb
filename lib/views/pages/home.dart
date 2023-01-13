import 'dart:convert';

import 'package:airbnb_clone/views/components/FavorisItem.dart';
import 'package:airbnb_clone/views/pages/favoris.dart';
import 'package:airbnb_clone/views/pages/Articles.dart';
import 'package:airbnb_clone/views/pages/tips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/Constants.dart';
import '../../controllers/home_controller.dart';
import '../../models/Address.dart';
import '../../models/Appartement.dart';
import '../../models/Hotel.dart';
import '../../models/Property.dart';
import 'favoris_list_page.dart';
import 'home_screen.dart';
import 'messages.dart';
import 'profile_page.dart';
import 'profile1.dart';
import 'profile_page.dart';
import 'login.dart';

class HomePage extends GetView<HomeController>{

  @override
  HomeController controller = Get.put(HomeController());

  final List<Widget> _children=[Articles(),FavorisListPage(),TipsPage(),MessagesPage(),ProfilePage()];


  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //controller.databaseService.test();
    return Obx(() =>
      Scaffold(
      backgroundColor: const Color(0XFFE7EBEE),
      body: SafeArea(
        child: _children[controller.currentTab.value],
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          selectedItemColor: Constants.redAirbnb,
          unselectedItemColor: Colors.grey[800],
          type: BottomNavigationBarType.fixed,
          onTap: (int value) {
            controller.currentTab.value=value;
          },
          currentIndex:controller.currentTab.value,
          items:const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              label: "Explorer",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_outlined,
                //color: Colors.black,
                size: 25,
              ),
              label: "Favoris",
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage("assets/images/airbnb_black_icon.png"),
                height: 25,
              ),
              label: "Voyages",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline_rounded,

                size: 25,
              ),
              label: "Boite de reception",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 25,
              ),
              label: "Profil",
            )
          ]
      ),
    )
    );
  }

}