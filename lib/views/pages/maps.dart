import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../commons/Constants.dart';
import '../../controllers/property_controller.dart';
import '../components/boxShadow.dart';

class MapsView extends GetView {
  PropertyController propertyController = Get.find<PropertyController>();
  static CameraPosition center = const CameraPosition(
      target: LatLng(14.716677, -17.467686), zoom: 12.0, tilt: 0, bearing: 0);

  late GoogleMapController mapController;

  MapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: center,
              zoomGesturesEnabled: true,
              markers: Set<Marker>.of(propertyController.markers.value),
              onMapCreated: (GoogleMapController c) {
                mapController = c;
              },
            ),
          ),
          Positioned(
              top: 15,
              right: 15,
              child: WBoxShadow(
                  padding: const EdgeInsets.all(5.0),
                  height: 50,
                  width: 50,
                  background: Colors.white,
                  radius: 30,
                  child: Center(
                    child: IconButton(
                        onPressed: () async {
                          Position position =
                              await controller.determinePosition();
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  tilt: 80,
                                  zoom: 16,
                                  target: LatLng(
                                      position.latitude, position.longitude))));
                          controller.showMarkerInCurrentPosition(position);
                        },
                        icon: const Icon(
                          Icons.gps_fixed,
                          color: primaryColor,
                        )),
                  ))),
          Positioned(
              top: 80,
              right: 15,
              child: WBoxShadow(
                  padding: const EdgeInsets.all(5.0),
                  height: 50,
                  width: 50,
                  background: primaryColor,
                  radius: 30,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          try {
                            controller.sendLatLng();
                            // ignore: empty_catches
                          } catch (e) {}
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.white,
                        )),
                  )))
        ],
      ),
    ));
  }
}
