import 'Address.dart';
import 'Property.dart';

class Appartement extends Property{
  int? id;
  bool endroitEntier;
  bool chambrePartage;
  bool equipe;

  Appartement(String titre, List<String> images, int prix, Address address,
      String descreption, double raiting, Commodite commodite,
      this.endroitEntier,this.chambrePartage,this.equipe, lat, lng, idUser)
 :   super(
        titre,
        images,
        prix,
        address,
        descreption,
        raiting,
        commodite,
    lat,
    lng,
      idUser);

  factory Appartement.fromJson(dynamic json) {
    return Appartement(json['titre'] as String,
      List<String>.from(json['images']),
      json['prix'] as int,
      Address.fromJson(json['address']),
      json['descreption'] as String,
      json['raiting'] as double,
      Commodite.fromJson(json['commodite']),
      json['endroitEntier'] as bool,
      json['chambrePartage'] as bool,
      json['equipe'] as bool,
      json['lat'] as String,
      json['lng'] as String,
      json['idUser'] as String,
    );
  }

  Map toJson() {
    Map? jsonCommodite =
    commodite != null ? this.commodite.toJson() : null;
    return {
      'titre': titre,
      'images': images,
      'prix': prix,
      'address': address,
      'descreption': descreption,
      'raiting': raiting,
      'commodite': jsonCommodite,
      'endroitEntier': endroitEntier,
      'chambrePartage': chambrePartage,
      'equipe': equipe,
      'lat': lat,
      'lng': lng,
      'idUser': idUser
    };
  }
}