
import 'dart:ffi';

import '../database/entities/message.dart';
import '../database/entities/utilisateur.dart';
import '../database/entities/utilisateur.dart';

class MessageModel {
  int? id;
  late double dateEnvoi;
  late String idDestinataire;
  late String idExpeditaire;
  late String nomExpeditaire;
  late String villeExpeditaire;
  String? message;

  MessageModel({this.id, required this.dateEnvoi, required this.idDestinataire, required this.idExpeditaire, required this.nomExpeditaire, required this.villeExpeditaire, this.message});

  Message toEntity() {
    var entity = Message(id, dateEnvoi.toString(), idDestinataire, idExpeditaire,message, nomExpeditaire, villeExpeditaire);
    return entity;
  }

  factory MessageModel.fromEntity(Message message){
    var messageModel = MessageModel(
        id: message.id, dateEnvoi: double.parse(message.dateEnvoi),
        idDestinataire: message.idDestinataire,
        nomExpeditaire: message.nomExpeditaire!,
        villeExpeditaire: message.villeExpeditaire!,
        idExpeditaire: message.idExpeditaire, message: message.message);

    return messageModel;
  }
}


