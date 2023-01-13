import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../commons/Constants.dart';

void showErrorDialogMaterial(List erreurs) {
  Get.defaultDialog(
    title: "Erreur".tr,
    titleStyle: const TextStyle(color: Colors.pink),
    middleText: erreurs.first.toString(),
    content: Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          erreurs.first.toString(),
          style: Get.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.error,
            size: 25,
            color: Colors.pink,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              primary: secondaryColor,
              shape: const StadiumBorder()),
          child: Text(
            "Reessayer".tr,
            style: GoogleFonts.alice(
                textStyle: const TextStyle(fontSize: 18, color: Colors.black)),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
  );
}
