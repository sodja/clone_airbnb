import 'dart:convert';

import 'package:airbnb_clone/views/components/FavorisItem.dart';
import 'package:airbnb_clone/views/pages/favoris.dart';
import 'package:airbnb_clone/views/pages/Articles.dart';
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

class TipsPage extends GetView<HomeController>{



  TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //controller.databaseService.test();
    return
      Scaffold(
      backgroundColor: const Color(0XFFE7EBEE),
      body: SafeArea(
        child: Container(
          child: Center(child: Text("Airbnb TIPS", style: TextStyle(color: Colors.black, fontSize: 15),),),
        ),
      ),

    );
  }

}