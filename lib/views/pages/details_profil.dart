import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/user_controller.dart';

class DetailsProfil extends GetView<UserController> {
  UserController userController = Get.find<UserController>();

  TextEditingController textarea = TextEditingController();

  DetailsProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onTap: () => {Get.back()},
            ),
            TextButton(
                onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Modifier le profil',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    height: 130,
                                    width: 130,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blueGrey),
                                    child: const Icon(
                                      Icons.person,
                                      size: 100,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "A propos de moi\n\n",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            (controller.aproposController
                                                            .text !=
                                                        "")
                                                ? Text(
                                                    controller.aproposController.text,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : const Text(
                                                    "Ecrivez quelque chose à propos de vous",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                              builder: (context) {
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      userController.updateApropos(controller
                                                                          .aproposController
                                                                          .text);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Text(
                                                                          'OK',
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.underline,
                                                                              color: Colors.black,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: const [
                                                                  Text(
                                                                      'A propos de moi',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start),
                                                                ]),
                                                            const Text(
                                                              'Parlez-nous un peu de vous afin que vos futurs hôtes ou voyageurs puissent mieux vous connaitre',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 3,
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            TextField(
                                                              controller: controller
                                                                  .aproposController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              autofocus: true,
                                                              maxLines: 4,
                                                              decoration: const InputDecoration(
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              Colors.grey))),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                          ],
                                                        )));
                                              });
                                        },
                                        child: const Text(
                                          "Ajouter",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(color: Colors.grey, height: 1),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Emplacement\n\n",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "Saisissez votre emplacement",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        "Ajouter",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(color: Colors.grey, height: 1),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Emploi\n\n",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            (controller.emploiController
                                                            .text !=
                                                        "")
                                                ? Text(
                                                    controller.emploiController.text,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : const Text(
                                                    "Saisissez la profession",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                              builder: (context) {
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      const Text(
                                                                        "Emploi",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      controller.updateEmploi(controller
                                                                          .emploiController
                                                                          .text);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Text(
                                                                          'OK',
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.underline,
                                                                              color: Colors.black,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Divider(
                                                              height: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            TextField(
                                                              controller: controller
                                                                  .emploiController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              autofocus: true,
                                                              maxLines: 1,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      "Saisissez la profession",
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              Colors.black))),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                          ],
                                                        )));
                                              });
                                        },
                                        child: const Text(
                                          "Ajouter",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(color: Colors.grey, height: 1),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Langues\n\n",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "Ajouter des langues",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        "Ajouter",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            );
                          })
                    },
                child: const Text(
                  "Modifier",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Container(
                margin: const EdgeInsets.only(right: 2),
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey),
                child: InkWell(
                  child: !controller
                      .profilePicFile
                      .value
                      .isAbsolute
                      ? IconButton(
                      icon: const Icon(
                        Icons.person,
                        size: 50,
                      ),
                      onPressed: () {
                        showPopupImage(
                            context);
                      })
                      : GestureDetector(
                    onTap: () {
                      showPopupImage(
                          context);
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                              50),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0,
                                    2),
                                blurRadius:
                                4,
                                color:
                                Colors.black38)
                          ],
                          image: DecorationImage(
                              image: FileImage(controller
                                  .profilePicFile
                                  .value),
                              fit: BoxFit
                                  .cover)),
                    ),
                  ),
                ),
              )),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userController.userModel.value.prenom} ",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Membre depuis ${userController.userModel.value.dateInscription} ",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Icon(
                Icons.backup_table,
                size: 50,
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Vérification de l'identité",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Grâce à ce badge, les autres utilisateurs savent que vous avez confirmé votre identié",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.black)),
                  ),
                  child: const Text("Obtenir le badge",
                      style: TextStyle(fontSize: 12, color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "A propos de",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${userController.userModel.value.apropos} ",
                    style:
                        const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Robert ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.black,
                  ),
                  Text(
                    "  Numéro de téléphone",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showPopupImage(context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              title: Text("choice_picture".tr, style: Get.textTheme.bodyText1),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      userController.uploadImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.camera),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("take_picture".tr,
                              style: Get.textTheme.bodyText2),
                        ),
                      ],
                    )),
                CupertinoActionSheetAction(
                    onPressed: () {
                      userController.uploadImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.photo),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("import_picture".tr,
                              style: Get.textTheme.bodyText2),
                        ),
                      ],
                    )),
              ],
            ));
  }
}
