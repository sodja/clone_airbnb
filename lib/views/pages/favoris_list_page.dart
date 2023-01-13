import 'package:airbnb_clone/commons/Constants.dart';
import 'package:airbnb_clone/models/Property.dart';
import 'package:airbnb_clone/views/components/FavorisItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import '../../controllers/property_controller.dart';

class FavorisListPage extends GetView{

  PropertyController propertyController = Get.find<PropertyController>();

  FavorisListPage({super.key});

  @override
  Widget build(BuildContext context) {
    propertyController.getAllFavorite();
    return Scaffold(
      body: SafeArea(
        child:
            Obx(() => ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Column(
                  children: [
                    Padding(padding: EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(width: 2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                child: Text('Download', style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(width: 2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                child: Text('Download', style: TextStyle(color: Colors.black)),
                              ),
                            )
                          ]),),
                  ],
                ),
                for(Property property in propertyController.favoriteProperties)
                  FavorisItemPage(localProperty: property),
              ],
            )),

      ),
    );
  }

}