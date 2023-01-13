import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

import '../commons/share_preferrences.dart';
import '../models/Appartement.dart';
import '../models/Hotel.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';
import '../views/components/ImageView.dart';

class PropertyController extends GetxController {
  var currentTab = 0.obs;
  var properties = [].obs;
  var searchProperties = [].obs;
  var favoriteProperties = [].obs;
  final RxList<Marker> markers = <Marker>[].obs;
  Set<Marker> _markers = {};
  var typeArticles = [].obs;
  var currentArticle = ''.obs;
  var searchText = ''.obs;
  var userName = ''.obs;
  var map = false.obs;
  final DataBaseService databaseService = DataBaseService();
  final appStorage = AirbnbSharePreference();
  var userModel = UserModel(nom: '').obs;

  @override
  void onInit() {
    databaseService.test().then((value) {
      print("object");
      if(value){
        getAllArticlesBySearch("");

        databaseService.getAllTypeArticle().then((value) {
          typeArticles.value = [];
          for (var element in value) {
            print(element.id);
            typeArticles.add(element);
          }
          Future.delayed(const Duration(seconds: 2), () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if(appStorage.getCurrentUserID() != null){
                Get.toNamed('home');
              } else {
                Get.offAllNamed("login");
              }
            });
          });
          //  controller.databaseService.updateArticleById(value.first.id!, true);
        });
      }
    });
    super.onInit();
  }


  getUserInfo(){
    databaseService.getUserInfos().then((value) {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      if(value.isNotEmpty){
        print(value.last.id);
        userModel.value = UserModel.fromEntity(value.last);
        print(userModel.value.remoteId);
        userName.value = userModel.value.nom?? "";
      }
    });
  }

  getAllFavorite() {
    favoriteProperties.value = [];
    databaseService.getAllFavoritesArticle().then((value) {
      for (var element in value) {
        print(element.id);
        Map<String, dynamic> map = jsonDecode(element.property);
        if (element.idType == "hotel") {
          Hotel hotel = Hotel.fromJson(map);
          hotel.id = element.id;
          favoriteProperties.add(hotel);
        } else {
          Appartement appartement = Appartement.fromJson(map);
          appartement.id = element.id;
          favoriteProperties.add(appartement);
        }
      }
      //
    });
  }

  getAllArticles() {
    properties.value = [];
    databaseService.getAllArticle().then((value) {
      for (var element in value) {
        print(element.id);
        Map<String, dynamic> map = jsonDecode(element.property);
        if (element.idType == "hotel") {
          Hotel hotel = Hotel.fromJson(map);
          hotel.id = element.id;
          print(hotel.id);
          addMarkerToMap(double.parse(hotel.lat), double.parse(hotel.lng),
              hotel.id!.toString(), hotel.prix.toString(), hotel.titre);
          properties.add(ImageProperty(false, hotel.id!, hotel));
        } else {
          Appartement appartement = Appartement.fromJson(map);
          appartement.id = element.id;
          print(appartement.titre);
          addMarkerToMap(double.parse(appartement.lat),
              double.parse(appartement.lng),
              appartement.id!.toString(), appartement.prix.toString(), appartement.titre);
          properties.add(ImageProperty(false, appartement.id!, appartement));
        }
      }
      //
    });
  }

  getAllArticlesBySearch(String searchKey) {
    print(searchKey);
    markers.value = [];
    _markers = {};
    if (searchKey.trim() == "") {
      getAllArticles();
    } else {
      if (properties.isNotEmpty) {
        for (ImageProperty property in properties) {
          print(property.property.titre);
          if (property.property.titre.toLowerCase().contains(searchKey) ||
              property.property.address.pays.toLowerCase().contains(searchKey) ||
              property.property.prix.toString().toLowerCase().contains(searchKey)) {
            addMarkerToMap(double.parse(property.property.lat),
                double.parse(property.property.lng),
                property.property.id!.toString(),
                property.property.prix.toString(),
            property.property.titre);
            searchProperties.add(property);
          }
        }
        if(searchProperties.isNotEmpty){
          properties.value = [];
          properties.addAll(searchProperties);

        }
      }
    }
  }
  late Uint8List bytes;

  Future<void> markerImage()async {
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();
  }
  Future<void> addMarkerToMap(double lat, double lng, String id, String price, String title) async {
    print("***************////////////////");
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();
    _markers.addLabelMarker(LabelMarker(
        markerId: MarkerId(id),
        draggable: false,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title),
        backgroundColor: Colors.redAccent,
        textStyle : TextStyle(
          fontSize: 35.0,
          color: Colors.white,
          letterSpacing: 1.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto Bold',
        ),
        icon: BitmapDescriptor.fromBytes(bytes),
        onTap: (() {
          FocusScopeNode currentFocus = FocusScope.of(Get.context!);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }), label: '$price CFA'),
    );
    markers.addAll(_markers.toList());
    }
}
