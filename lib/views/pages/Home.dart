import 'package:airbnb_clone/controllers/home_controller.dart';
import 'package:airbnb_clone/views/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/constants.dart';
import 'HomeScreen.dart';

class HomePage extends GetView<HomeController>{

  @override
  HomeController controller = HomeController();

  final List<Widget> _children=[HomeScreen(),LoginPage(),LoginPage(),LoginPage()];


  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
      backgroundColor: const Color(0XFFE7EBEE),
      body: SafeArea(
        child: _children[controller.currentTab.value],
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          selectedItemColor: redAirbnb,
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