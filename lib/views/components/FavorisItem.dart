import 'package:airbnb_clone/views/pages/favoris.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/Constants.dart';
import '../../models/Property.dart';

class FavorisItemPage extends GetView {

  var property = Constants.properties[1];

  FavorisItemPage({Key? key, Property? localProperty}) : super(key: key) {
    if (localProperty != null) {
      property = localProperty;
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {Get.to(() => Favoris(localProperty: property,))},
        child: Card(
            margin: EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            color: Theme.of(context).colorScheme.surfaceVariant,
            elevation: 2,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: SizedBox(
              height: 80,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Image.asset(
                            property.images[0],
                            fit: BoxFit.cover,
                          )),
                      Expanded(
                          child: Text(
                        property.titre,
                        textAlign: TextAlign.center,
                      ))
                    ],
                  )),
            )));
  }
}
