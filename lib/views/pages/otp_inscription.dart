import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../commons/Constants.dart';
import '../../controllers/inscription_controller.dart';
import '../components/container.dart';

// ignore: must_be_immutable
class OtpInscriptionPage extends GetView<OtpInscriptionController> {
  @override
  OtpInscriptionController controller = Get.put(OtpInscriptionController());
  OtpInscriptionPage({Key? key}) : super(key: key) {}

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: BoxContainer(
                    width: 30,
                    height: 30,
                    radius: 15,
                    background: Colors.white,
                    child: IconButton(
                      icon: Obx(()=> (controller.currentLange.value == 'fr')?
                      const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black,
                      ): const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      )) ,
                      onPressed: () {
                        Get.back();
                      },
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                "assets/images/logo.png",
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text("Saisissez le code envoyé par SMS",
                  textAlign: TextAlign.center, style: Get.textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin) async {
                  controller.isCompleted.value = true;
                  controller.verifyOpt(pin);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text(
                "Entrer le code envoyé à ".tr + controller.inscriptionController.phoneController.text!,
                textAlign: TextAlign.center,
              ),
            ),
            Obx(() => controller.isCompleted.value == true
                ? const Padding(
                    padding: EdgeInsets.symmetric(),
                    child: CupertinoActivityIndicator(radius: 15, color: primaryColor,),
                  )
                : const Text("")),
          ],
        ),
      ),
    ));
  }
}
