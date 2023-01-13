import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_codes/country_codes.dart';
import 'package:encryptor/encryptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../commons/share_preferrences.dart';
import '../services/user_services.dart';
import '../views/components/dialog.dart';

class LoginController extends GetxController {
  var inscription = false.obs;
  var isLoading = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserService userService = UserService();
  final _appStorage = AirbnbSharePreference();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Controller observers
  var isCompleted = false.obs;
  var erreurs = [].obs;
  var verificationCode = '';
  var hashPassword = '';
  var identifiant = ''.obs;
  var currentLange = 'fr'.obs;

  final CountryDetails details = CountryCodes.detailsForLocale();

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordController = TextEditingController();
    identifiant.value = details.dialCode!;
    super.onInit();
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
  }

  Future verifyPhone() async {
    isLoading.value = true;
    erreurs.value = [];
    if (emailController.text.isNotEmpty && !emailController.text.isEmail) {
      erreurs.add("l'adresse email n'est pas valide");
      showErrorDialogMaterial(erreurs);
      isLoading.value = false;
      return null;
    }
    userService.fetchUsersByPhone(phoneController.text).then((value) {
      if(value.docs.isEmpty){
        final code = details.dialCode;
        hashPassword =
            Encryptor.encrypt('sterne', passwordController.text)
                .toString();
        auth.verifyPhoneNumber(
            phoneNumber: '${phoneController.text}',
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {
              debugPrint('test 5 $e');
              isLoading.value = false;
              erreurs.add("La vérification du numéro a échoué\n");
              showErrorDialogMaterial(erreurs);
            },
            codeSent: (String verificationId, int? resendToken) {
              debugPrint('test 6');
              isLoading.value = false;
              Get.toNamed('otp');
              phoneController.text = phoneController.text;
              verificationCode = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              verificationCode = verificationId;
            },
            timeout: const Duration(seconds: 60));

        debugPrint('test 7');
      } else {
        isLoading.value = false;
        erreurs.add("Ce numéro existe déjà\n");
        showErrorDialogMaterial(erreurs);
      }
    });

  }


  login() async {
    print( Encryptor.encrypt('sterne', passwordController.text).toString());
    print( emailController.text);
    isLoading.value = true;
    erreurs.value = [];
    if (erreurs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email',
          isEqualTo:  emailController.text)
          .where('password',
          isEqualTo: Encryptor.encrypt('sterne', passwordController.text).toString())
          .get()
          .then((userDoc) {
        if (userDoc.docs.isNotEmpty) {
          _appStorage.saveCurrentUserID(userDoc.docs[0].id);
          isLoading.value = false;
          clear();
          Get.offAllNamed('loading');
        } else {
          erreurs.add("Email ou mot de passe\nincorrect");
          showErrorDialogMaterial(erreurs);
          isLoading.value = false;
        }
      });
    } else {
      showErrorDialogMaterial(erreurs);
      isLoading.value = false;
    }
  }

}