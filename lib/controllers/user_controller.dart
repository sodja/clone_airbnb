import 'dart:io';

import 'package:airbnb_clone/models/user_model.dart';
import 'package:airbnb_clone/services/user_services.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../commons/Constants.dart';
import '../commons/share_preferrences.dart';
import '../services/database_service.dart';
import '../views/components/custom_snack_bar.dart';

class UserController extends GetxController{
  final DataBaseService databaseService = DataBaseService();
  final UserService userService = UserService();
  late TabController controller;
  var userModel = UserModel(nom: '').obs;
  final TextEditingController aproposController = TextEditingController();
  final TextEditingController emploiController = TextEditingController();
  final TextEditingController languesController = TextEditingController();
  final appStorage = AirbnbSharePreference();
  var profilePicFile = File("").obs;
  var userImage = 'https://firebasestorage.googleapis.com/v0/b/ocoapp-ebe9a.appspot.com/o/profiles%2FHWTSsv6iPkZLyxmsw7inUhkmViC3%2F1066674716?alt=media&token=5288354d-880f-4b8c-8371-1fdfc3846f32'.obs;

  @override
  void onInit() {
  //  databaseService.test();
    super.onInit();
  }

  getUserInfo(){
    databaseService.getUserInfos().then((value) {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      if(value.isNotEmpty){
        print(value.last.id);
        userModel.value = UserModel.fromEntity(value.last);
        print(userModel.value.remoteId);
        emploiController.text = userModel.value.emploi?? "";
        aproposController.text = userModel.value.apropos?? "";
      }
    });
  }

  uploadImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      profilePicFile.value = File(pickedFile.path);
      userService.saveUserProfile(profilePicFile.value).then((value) {
        userModel.value.photoUrl = userService.photoUrl;
        databaseService.updateUser(userModel.value);
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "photo de profil mis à jours".tr,
            backgroundColor: primaryColor);
      }).catchError((error){
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "Une erreur est survenue, réessayer ultérieurement".tr,
            backgroundColor: errorColor);
      });
    } else {
      Get.snackbar('Erreur'.tr, 'empty_picture'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: secondaryColor,
          colorText: Colors.black);
    }
  }
  updateApropos(String apropos){
    if(apropos.trim() != userModel.value.emploi && userModel.value.nom !=""){
      userModel.value.apropos = apropos;
      print("%%%%%%%%999");
      print(userModel.value.id);
      userService.updateUserApropos(userModel.value).then((value){
        databaseService.updateUser(userModel.value);
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "le profil mis à jours".tr,
            backgroundColor: primaryColor);
      }).catchError((error){
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "Une erreur est survenue, réessayer ultérieurement".tr,
            backgroundColor: errorColor);
      });
    }
  }

  updateEmploi(String emploi){
    if(emploi.trim() != userModel.value.emploi && userModel.value.nom !=""){
      userModel.value.emploi = emploi;
      print(userModel.value.entityId);
      userService.updateUserEmploi(userModel.value).then((value){
        databaseService.updateUser(userModel.value).then((value) {
          print(value);
        }).catchError((onError){
          print(onError);
        });
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "le profil mis à jours".tr,
            backgroundColor: primaryColor);
      }).catchError((error){
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "Une erreur est survenue, réessayer ultérieurement".tr,
            backgroundColor: errorColor);
      });
    }
  }

  updateLangues(String langues){
    if(langues.trim() != userModel.value.langues && userModel.value.nom !=""){
      userModel.value.langues = langues;
      userService.updateUserLangue(userModel.value).then((value){
        databaseService.updateUser(userModel.value);
        CustomToastBar.showToastBar(
            context: Get.context,
            title: "profil".tr,
            message: "le profil mis à jours".tr,
            backgroundColor: primaryColor);
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