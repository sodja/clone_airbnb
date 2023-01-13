import 'dart:typed_data';

import 'package:airbnb_clone/views/components/DetailImageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../commons/Constants.dart';
import '../../controllers/property_controller.dart';
import '../../models/Property.dart';

class DetailsArticle extends GetView {
  PropertyController propertyController = Get.find<PropertyController>();

  final _pageController = PageController();
  var _currentIndex = 0;

  var searchText = ''.obs;
  var currentTab = 0.obs;
  late Property _detailProperty;
  Set<Marker> markers = Set(); //markers for google map
  late GoogleMapController mapController;

  Widget property = DetailImageProperty(false, 1, Constants.properties[1]);

  DetailsArticle({Key? key, Property? localProperty}) : super(key: key) {
    if (localProperty != null) {
      property = DetailImageProperty(true, 1, localProperty);
      _detailProperty = localProperty;
      propertyController.markerImage();
      markers.add(Marker(
        //add start location marker
        markerId: MarkerId(_detailProperty.id.toString()),
        position: LatLng(double.parse(_detailProperty.lat),
            double.parse(_detailProperty.lng)), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: _detailProperty.titre,
          snippet: _detailProperty.descreption,
        ),//Icon for Marker
      ));

    }
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      _currentIndex = _pageController.page!.round();
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.00,
        toolbarHeight: 50,
      ),
      body: SizedBox.expand(
          child: Column(children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(1),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              property,
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "C'est une perle rare. Reservations Airbnb chez ${_detailProperty.titre} sont souvent complètes",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.diamond_rounded,
                              size: 30,
                              color: Constants.redAirbnb,
                            )),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Logement entier: \n ${_detailProperty.titre} .",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.recommend,
                                  size: 50,
                                  color: Constants.greenAirbnb,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "2 voyageur - ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "2 chambres - ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "1 lit",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "1 salle de bain",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Icon(
                                  Icons.door_front_door_outlined,
                                  size: 25,
                                  color: Constants.blackAirbnb,
                                )),
                            Expanded(
                              child: Text(
                                "Arrivée autonome",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(right: 25),
                                child: Icon(
                                  Icons.door_front_door_outlined,
                                  size: 1,
                                  color: Constants.blackAirbnb,
                                )),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Text(
                                  "Vous pouvez entrer dans les lieux avec une boite à clé sécurisée.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Icon(
                                  Icons.military_tech,
                                  size: 25,
                                  color: Constants.blackAirbnb,
                                )),
                            Expanded(
                              child: Text(
                                "Uni est Superhôte",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(right: 25),
                                child: Icon(
                                  Icons.military_tech,
                                  size: 1,
                                  color: Constants.blackAirbnb,
                                )),
                            Expanded(
                              child: Text(
                                "Les Superhôtes sont des hôtes expérimentées qui bénéficient de très bonnes évalutions et qui s'engagent à offrir d'excellents séjours aux voyageurs.",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Icon(
                                  Icons.military_tech,
                                  size: 25,
                                  color: Constants.blackAirbnb,
                                )),
                            Expanded(
                              child: Text(
                                "Annulation gratuites pendant 48heures",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ce que propose ce logement",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text(
                              "Vue sur le jardin",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.yard_outlined,
                                  size: 15,
                                  color: Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text(
                              "Vue sur la montagne",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 15,
                                  color: Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text(
                              "Accès plage ou bord de mer",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.pool_outlined,
                                  size: 15,
                                  color: Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Cuisine",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration:
                                      !_detailProperty.commodite.repasInclus
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.dining_outlined,
                                  size: 15,
                                  color: !_detailProperty.commodite.repasInclus
                                      ? Colors.grey
                                      : Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Wifi",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration: !_detailProperty.commodite.wifi
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.wifi,
                                  size: 15,
                                  color: !_detailProperty.commodite.wifi
                                      ? Colors.grey
                                      : Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Parking gratuit dans la rue",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration: !_detailProperty.commodite.Parking
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.directions_car_outlined,
                                  size: 15,
                                  color: !_detailProperty.commodite.Parking
                                      ? Colors.grey
                                      : Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Piscine Partagée",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration: !_detailProperty.commodite.piscine
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.pool_sharp,
                                  size: 15,
                                  color: !_detailProperty.commodite.piscine
                                      ? Colors.grey
                                      : Constants.blackAirbnb,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Détecteur de monoxyde de carbone",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration: !_detailProperty.commodite.equipe
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.co2_outlined,
                                  size: 15,
                                  color: !_detailProperty.commodite.equipe
                                      ? Colors.grey
                                      : Colors.black,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Détecteur de fumée",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  decoration: !_detailProperty
                                          .commodite.InterdectionFumee
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.smoke_free_outlined,
                                  size: 15,
                                  color: !_detailProperty
                                          .commodite.InterdectionFumee
                                      ? Colors.grey
                                      : Constants.blackAirbnb,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(child:
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // <-- Radius
                                ),
                                elevation: 0,
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                )),
                            child: const Text(' Afficher les autres équipements '))
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Où se situe ${_detailProperty.titre}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Text(
                              "${_detailProperty.address.codePostal}, "
                              "${_detailProperty.address.rue},"
                              " ${_detailProperty.address.pays}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal)),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              margin: const EdgeInsets.all(15),
                              elevation: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 200,
                                      child: GoogleMap(
                                        myLocationEnabled: false,
                                        zoomControlsEnabled: false,
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(double.parse(_detailProperty.lat), double.parse(_detailProperty.lng)), zoom: 14.0, tilt: 0, bearing: 0),
                                        zoomGesturesEnabled: false,
                                        markers: markers,
                                        onMapCreated: (GoogleMapController c) {
                                          mapController = c;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ]),
                    //TODO Integrate map there
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Disponibilité",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "24-29 janvier 2023",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 20, color: Colors.black)
                          ],
                        ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Conditions d'annulation",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Annulation gratuite pendant 48 heures.\n Consultez les conditions d'annulation complètes de l'hôte, "
                                  "qui s'appliquent même si vous annulez pour cause maladie de perturbations causées par le covid-19.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )),
                            const Icon(Icons.arrow_forward_ios,
                                size: 20, color: Colors.black)
                          ],
                        ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Règlement intérieur",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Arrivée: entre 15:00 et 22:00\n"
                          "Départ avant 11:00\n"
                          "2 voyageurs maximum",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Savoir plus",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(1.0)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                color: Colors.grey,
                blurRadius: 2,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${_detailProperty.prix}\$ ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          const Text("par mois",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                      const Text("24-29 janv",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline))
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.redAirbnb,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal)),
                  child: const Text("Reserver"))
            ],
          ),
        )
      ])),
    );
  }
}
