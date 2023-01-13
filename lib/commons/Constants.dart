import 'dart:ui';

import '../models/Address.dart';
import '../models/Appartement.dart';
import '../models/Hotel.dart';
import '../models/Property.dart';

class Constants {

  static List<Property> properties = [
    Hotel(
      "hotel",
      ['assets/images/properties/p1.jpg', "assets/images/properties/p2.jpg"],
      5000,
      Address("Niamey", "Niger", "Boufarik", "el mo9rani", "15", "09025"),
      "description  qui peut depasser 3 lignes donc la suite sera cachée until clicking the button afficher la suite pour l'afficher. voici une démonstration qui le fait ",
      5,
      Commodite(
          true,
          true,
          false,
          true,
          true,
          true,
          true,
          true,
          true),
      true,
      false,
      true,
        "14.756766",
        "-17.467688",
      "14.756766",

    ),

    Appartement(
      "appartement",
      ['assets/images/properties/p3.jpg', "assets/images/properties/p2.jpg"],
      2500,
      Address("Sénégal", "Dakar", "Reghaia", "el hadad", "55", "16025"),
      "description  qui peut depasser 3 lignes donc la suite sera cachée until clicking the button afficher la suite pour l'afficher. voici une démonstration qui le fait ",
      4.0,
      Commodite(
          true,
          true,
          false,
          true,
          true,
          true,
          true,
          true,
          true),
      true,
      false,
      true,
        "14.756766",
        "-17.468900",
      "14.756766",
    ),
  ];



  static const primaryColor = Color(0xFF0ba75d);
  static const secondaryColor = Color(0xFFF9FAB2);
  static const errorColor = Color(0xFFF87A6F);
  static const whiteColor = Color(0xFFFFFFFF);
  static const thirdColor = Color(0xFF9BBE5F);
  static const redAirbnb = Color(0xffFF5A5F);
  static const greenAirbnb = Color(0xff00A699);
  static const blackAirbnb = Color(0xff232222);
}
const primaryColor = Color(0xFF0ba75d);
const secondaryColor = Color(0xFFF9FAB2);
const secondaryListColor = Color(0xDBF9FAB2);
const errorColor = Color(0xFFF87A6F);
const whiteColor = Color(0xFFFFFFFF);
const thirdColor = Color(0xFF9BBE5F);