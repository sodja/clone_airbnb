import 'Address.dart';
import 'Property.dart';

class Chambre extends Property{
  bool sanitairePrive;
  bool chambrePartage;
  bool equipe;

  Chambre(String titre, List<String> images, int prix, Address address,
      String descreption, double raiting, Commodite commodite,
      this.sanitairePrive,this.chambrePartage,this.equipe,
  lat,
  lng,idUser)
      :   super(
      titre,
      images,
      prix,
      address,
      descreption,
      raiting,
      commodite,
    lat,
    lng,idUser);

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
      'lat': lat,
      'lng': lng,
      'idUser': idUser,
    };
  }
}
