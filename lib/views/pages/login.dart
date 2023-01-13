import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/Constants.dart';
import '../../controllers/login_controller.dart';
import '../components/components.dart';
import '../components/loading.dart';

class LoginPage extends GetView {
  @override
  final LoginController controller = Get.put(LoginController());

  LoginPage({super.key});

  @override
  build(BuildContext context) {
    return Obx(() => Stack(children: [
          Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Obx(
                () => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 130,
                          width: 130,
                          child: Image(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const Text(
                          "Bienvenue sur",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Visibility(
                          visible: controller.inscription.value,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: customDecoration(),
                            child: TextFormField(
                              controller: controller.nameController,
                              decoration: InputDecoration(
                                  hintText: "Nom & prénom",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Constants.greenAirbnb,
                                  )),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.inscription.value,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: customDecoration(),
                            child: TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: "Téléphone",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(
                                    Icons.smartphone,
                                    color: Constants.greenAirbnb,
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: customDecoration(),
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Constants.greenAirbnb,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: customDecoration(),
                          child: TextFormField(
                            obscureText: true,
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                                hintText: "Mot de passe",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Constants.greenAirbnb,
                                )),
                          ),
                        ),
                        Visibility(
                          visible: !controller.inscription.value,
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Mot de passe oublié ?",
                                  style: TextStyle(
                                      color: Constants.greenAirbnb,
                                      fontSize: 12),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: controller.inscription.value ? 30 : 0,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (!controller.inscription.value) {
                              controller.login();
                            } else {
                              controller.verifyPhone();
                            }
                          },
                          splashColor: Colors.white,
                          hoverColor: Constants.greenAirbnb,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Constants.greenAirbnb,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.grey,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Center(
                                child: Text(
                              !controller.inscription.value
                                  ? "Connexion"
                                  : "Continuer",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.inscription.value =
                                !controller.inscription.value;
                            controller.clear();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: InkWell(
                                child: RichText(
                                  text: TextSpan(
                                      text: controller.inscription.value
                                          ? "Avez-vous un compte ? "
                                          : "Nouveau utilisateur ?",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: [
                                        TextSpan(
                                          text: controller.inscription.value
                                              ? "Connexion"
                                              : "Créer un compte",
                                          style: const TextStyle(
                                              color: Constants.greenAirbnb,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Ou continuer avec ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /* continueWith("assets/images/social_media/google.png"),
                    continueWith("assets/images/social_media/phone.png"),*/
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (controller.isLoading.value == true)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black87),
            ),
          if (controller.isLoading.value == true)
            DefaultCupertinoWidget(color: Constants.redAirbnb)
        ]));
  }
}
