import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

import '../commons/share_preferrences.dart';
import '../models/user_model.dart';

class UserService extends GetxService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection("users");
  final _firestorage = FirebaseStorage.instance;
  final _appStorage = AirbnbSharePreference();

  //var
  String verificationCode = '';
  String photoUrl = '';



  Future<int> userCount() async {
    int count = 0;
    await _firestore.get().then((value) {
      count = value.docs.length;
    });
    return count;
  }

  Future verifyPhone(String name, String phone, String password, bool isCreating) {
    return auth.verifyPhoneNumber(
        phoneNumber: '+222$phone',
        verificationCompleted: (PhoneAuthCredential credential) {
          auth.signInWithCredential(credential).then((user) async => {});
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('test 5 erreur');
        //  Get.toNamed('/inscription');
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint('test 6');
          verificationCode = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: const Duration(seconds: 60));
  }

  Stream<QuerySnapshot> fetchUsers() {
    return _firestore.snapshots();
  }

  Future<UserModel> updateUserApropos(UserModel user) async {
    print(user.remoteId);
    await _firestore.doc(user.remoteId).update({'apropos': user.apropos});
    return user;
  }

  Future<UserModel> updateUserEmploi(UserModel user) async {
    await _firestore.doc(user.remoteId).update({'emploi': user.emploi});
    return user;
  }


  Future<UserModel> updateUserLangue(UserModel user) async {
    await _firestore.doc(user.remoteId).update({'langues': user.langues});
    return user;
  }

  Future<DocumentSnapshot> getUserById(String id) async {
    return _firestore.doc(id).get();
  }

  Future verifyOtp(String pin, String name, String phone, String password,
      bool isCreating) async {
    try {
      return await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: pin))
          .then((user) async {
        print(user);
        //sign in was success
        return "OK";
      }).catchError((error) => {debugPrint('error' + error)});
    } catch (e) {
      debugPrint('error du code pin');
      throw Exception("error du code pin");
    }
  }

  Future<QuerySnapshot> fetchUsersByPhone(String searchkey) {
    return _firestore
        .where("phone",
        isGreaterThanOrEqualTo: searchkey,
        isLessThan: searchkey.substring(0, searchkey.length - 1) +
            String.fromCharCode(searchkey.codeUnitAt(searchkey.length - 1) + 1)
    ).get();
  }

  Future<QuerySnapshot> fetchUsersByName(String searchkey) {
    return _firestore
        .where("name",
        isGreaterThanOrEqualTo: searchkey,
        isLessThan: searchkey.substring(0, searchkey.length - 1) +
            String.fromCharCode(searchkey.codeUnitAt(searchkey.length - 1) + 1)
    ).get();
  }


  Future<void> saveUserProfile(File? file) async {
    final userId = _appStorage.getCurrentUserID();

    await _firestorage
        .ref('profil/$userId/${file.hashCode.toString()}')
        .putFile(file!);
    Future.delayed(const Duration(seconds: 2), () async {
      var url = await getUserProfileUrl(file.hashCode.toString());
      String profileUrl = url!;
      _firestore.doc(userId).set(
          {"profileUrl": profileUrl}, SetOptions(merge: true)).then((value) {
            photoUrl = url;
        //Do your stuff.
      });
    });
  }

  Future<String?> getUserProfileUrl(String? imageName) async {
    if (imageName == null) return null;
    try {
      var urlRef = _firestorage
          .ref()
          .child("profil")
          .child(_appStorage.getCurrentUserID()!)
          .child(imageName);
      var imageUrl = await urlRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      debugPrint(e.toString());
      return "Erreur serveur";
    }
  }
}
