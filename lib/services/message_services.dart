import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import '../commons/share_preferrences.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class MessageService extends GetxService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection("message");
  final _firestorage = FirebaseStorage.instance;
  final _appStorage = AirbnbSharePreference();

  //var
  String verificationCode = '';
  String photoUrl = '';

  Stream<QuerySnapshot> fetchUsers() {
    return _firestore.snapshots();
  }

  Future<QuerySnapshot> fetchMessageSendedByUser(String userId) {
    return _firestore
        .where("id_destinataire", isEqualTo: userId).get();
  }

  Future<QuerySnapshot> fetchMessageSendedForUser(String userId) {
    return _firestore
        .where("id_expeditaire", isEqualTo: userId).get();
  }

  Future createMessage(MessageModel messageModel) async {
    return _firestore.add({
      'date_envoi': messageModel.dateEnvoi.toString(),
      'id_destinataire': messageModel.idDestinataire,
      'id_expeditaire': messageModel.idExpeditaire,
      'message': messageModel.message,
      'nom_expeditaire': messageModel.nomExpeditaire,
      'ville_expeditaire': messageModel.villeExpeditaire,
    }).then((value) {
      return value;
    }).catchError((onError) {
      debugPrint("Error saving card to db.$onError");
      return null;
    });
  }
}
