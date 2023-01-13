
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import '../commons/share_preferrences.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';
import '../services/message_services.dart';
import '../services/user_services.dart';

class HomeController extends GetxController{
  var currentTab=0.obs;
  final DataBaseService databaseService = DataBaseService();
  UserService userService = UserService();
  final MessageService messageService = MessageService();

  final _appStorage = AirbnbSharePreference();

  @override
  void onInit() {
    databaseService.deleteAll();
    saveUserInfosInLocalDb();
    saveMessageInLocalDb();
    super.onInit();
  }

  saveUserInfosInLocalDb(){
    var userId = _appStorage.getCurrentUserID()??"";
    userService.getUserById(userId).then((value) {
      print("µµµµµµµµµµµµµµµµµµµµµµµµµµµµµ");
      UserModel userModel = UserModel(nom: value.get("name"));
      userModel.telephone = value.get("phone");
      userModel.prenom = value.get("prenom");
      userModel.sexe = value.get("sexe");
      userModel.emploi = value.get("emploi");
      userModel.emplacement = value.get("emplacement");
      userModel.remoteId = value.id;
      userModel.dateNaissance = value.get("date_naissance");
      userModel.dateInscription = value.get("date_inscription");
      userModel.langues = value.get("langues");
      userModel.apropos = value.get("apropos");
      userModel.photoUrl = value.get("photoUrl");
      databaseService.insertUser(userModel);
    });
  }

  saveMessageInLocalDb(){
       var userId = _appStorage.getCurrentUserID()??"";
    messageService.fetchMessageSendedByUser(userId).then((value) {
      value.docs.forEach((element) {
        MessageModel messageModel = MessageModel(message: element.get("message"),
            dateEnvoi: double.parse(element.get("date_envoi")),idDestinataire: element.get("id_destinataire"),
            nomExpeditaire: element.get("nom_expeditaire"),villeExpeditaire: element.get("ville_expeditaire"),
            idExpeditaire: element.get("id_expeditaire")
        );
        databaseService.insertMessage(messageModel);
      });

    });

    messageService.fetchMessageSendedForUser(userId).then((value) {
      value.docs.forEach((element) {
        MessageModel messageModel = MessageModel(message: element.get("message"),
            dateEnvoi:  double.parse(element.get("date_envoi")),idDestinataire: element.get("id_destinataire"),
            nomExpeditaire: element.get("nom_expeditaire"),villeExpeditaire: element.get("ville_expeditaire"),
            idExpeditaire: element.get("id_expeditaire"));
        databaseService.insertMessage(messageModel);
      });

    });
  }

}