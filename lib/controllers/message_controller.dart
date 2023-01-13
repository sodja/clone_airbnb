
import 'dart:convert';

import 'package:airbnb_clone/models/message_model.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../commons/Constants.dart';
import '../commons/share_preferrences.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';
import '../services/message_services.dart';
import '../views/components/custom_snack_bar.dart';

class MessageController extends GetxController  with GetSingleTickerProviderStateMixin{
  final DataBaseService databaseService = DataBaseService();
  final MessageService messageService = MessageService();
  final _appStorage = AirbnbSharePreference();
  late TabController controller;
  var messages = [].obs;
  var detailMessages = [].obs;
  var nomExpeditaire = "".obs;
  var idDest = "".obs;
  var idExp = "".obs;
  var userModel = UserModel(nom: '').obs;

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    databaseService.test();
    controller = TabController(length: 2, vsync: this);
    getUserInfo();
    super.onInit();
  }

  getUserInfo(){
    databaseService.getUserInfos().then((value) {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      if(value.isNotEmpty){
        print(value.last.id);
        userModel.value = UserModel.fromEntity(value.last);
      }
    });
  }

  getAllMessage() {
    messages.value = [];
    var userId = _appStorage.getCurrentUserID()??"";
    messages.add(MessageModel(dateEnvoi: 12365455, idDestinataire: "idDestinataire", idExpeditaire: "idExpeditaire", message: "test dedeedekjfsjf", nomExpeditaire: "nomExpeditaire", villeExpeditaire: "villeExpeditaire"));
    databaseService.getAllMessageByUser(userId).then((value) {
      if(value.isNotEmpty){
        messages.value = [];
        for (var element in value) {
          print(element.id);
          var messageModel = MessageModel.fromEntity(element);
          messages.add(messageModel);
        }
      }
    });
  }

  getDetailsMessage(String idDest, String idExp) {
    detailMessages.value = [];
    databaseService.getAllMessageByIdDestAndIdExp(idDest, idExp).then((value) {
      for (var element in value) {
        print(element.id);
        var messageModel = MessageModel.fromEntity(element);
        detailMessages.add(messageModel);
      }
      //
    });
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      var date =DateTime.now().microsecondsSinceEpoch.toDouble();
      var messageModel = MessageModel(idExpeditaire: idDest.value, idDestinataire: idExp.value,
          message: messageController.text, villeExpeditaire: userModel.value.emplacement??"",
          nomExpeditaire: userModel.value.nom??"",dateEnvoi: date);
      messageService.createMessage(messageModel).then((value) {
        databaseService.insertMessage(messageModel).then((result) {
          getDetailsMessage(idDest.value, idExp.value);
          messageController.clear();
          print(result);
        }).catchError((onError){
          print(onError);
        });
      }).catchError((error){
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "Une erreur est survenue, réessayer ultérieurement".tr,
            backgroundColor: errorColor);
      });
    }
  }

}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}