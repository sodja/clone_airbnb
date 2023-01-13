import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../commons/Constants.dart';
import '../../controllers/property_controller.dart';

// ignore: must_be_immutable
class LoadingPage extends GetView<PropertyController> {
  @override
  PropertyController controller = Get.put(PropertyController());

  LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: Get.height / 2),
                child: Center(
                  child: Column(
                    children: [
                      const CupertinoActivityIndicator(
                        radius: 15,
                        color: primaryColor,
                      ),
                      Text(
                        "Chargement ...",
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ))));
  }
}
