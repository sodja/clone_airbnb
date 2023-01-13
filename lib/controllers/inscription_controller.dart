import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/user_services.dart';
import '../views/components/dialog.dart';
import 'login_controller.dart';

class OtpInscriptionController extends GetxController {

  LoginController inscriptionController = Get.find<LoginController>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserService userService = UserService();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Controller observers
  var isCompleted = false.obs;
  var erreurs = [].obs;
  var verificationCode = '';
  var hashPassword = '';
  var currentLange = 'fr'.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }


  Future<void> verifyOpt(String pin) async {
    erreurs.value = [];
    print(inscriptionController.verificationCode);
    try {
      var date = DateTime.now().toString();
      initializeDateFormatting('fr_FR', null).then((_)  {
        String formattedDate = DateFormat.yMMMMd('fr_FR').format( DateTime.now());
        date = formattedDate;
      });
      var user = await auth
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: inscriptionController.verificationCode, smsCode: pin.toString()))
          .then((user) async => {
        //sign in was success
        if (user != null)
          {
            //store registration details in firestore database
            await firestore
                .collection('users')
                .doc(auth.currentUser?.uid)
                .set({
              'name': inscriptionController.nameController.text,
              'phone': inscriptionController.phoneController.text,
              'email': inscriptionController.emailController.text,
              'password': inscriptionController.hashPassword,
              'apropos': "",
              'date_inscription': date,
              'emplacement': "",
              'emploi': "",
              'langues': "",
              'prenom': "",
              'sexe': "",
              'photoUrl': "",
              'date_naissance': "",
            }, SetOptions(merge: true)).then((value) => {}),
            inscriptionController.inscription.value = false,
            inscriptionController.clear(),
            Get.offAllNamed('login')
          }
        else
          {
            erreurs.add("le code saisi est incorrect!!!"),
            isCompleted.value = false,
            showErrorDialogMaterial(erreurs),
            debugPrint('error 2'),
          }
      })
          .catchError((error) {
        erreurs.add("le code saisi est incorrect!!!");
        isCompleted.value = false;
        showErrorDialogMaterial(erreurs);
        debugPrint('error 3');
      });
    } catch (e) {
      // erreurs.add(
      //     "une erreur s'est produite, merci de réessayer ultérieurement!!");
      // isCompleted.value = false;
      // showErrorDialogMaterial(erreurs);
      debugPrint('error4');
      debugPrint('error du code pin');
    }
  }


}
