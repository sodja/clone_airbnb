import 'Address.dart';

abstract class Property {
  int? id;
  String _titre;
  List<String> _images;
  int _prix;
  Address _address;
  String _descreption;
  double _raiting;
  String _lat;
  String _lng;
  String _id_user;
  Commodite _commodite;

  Commodite get commodite => _commodite;

  Address get address => _address;

  set address(Address value) {
    _address = value;
  }

  set commodite(Commodite value) {
    _commodite = value;
  }

  String get titre => _titre;

  set titre(String value) {
    _titre = value;
  }

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  String get lng => _lng;

  set lng(String value) {
    _lng = value;
  }

  String get idUser => _id_user;

  set idUser(String value) {
    _id_user = value;
  }

  Property(
      this._titre,
      this._images,
      this._prix,
      this._address,
      this._descreption,
      this._raiting,
      this._commodite,
      this._lat,
      this._lng,
      this._id_user);

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  int get prix => _prix;

  set prix(int value) {
    _prix = value;
  }

  String get descreption => _descreption;

  set descreption(String value) {
    _descreption = value;
  }

  double get raiting => _raiting;

  set raiting(double value) {
    _raiting = value;
  }
}

class Commodite {
  bool InterdectionFumee;

  bool serviceDeChambre;
  bool piscine;
  bool gym;
  bool repasInclus;
  bool wifi;
  bool enfantAutorise;
  bool Parking;
  bool equipe;

  Commodite(
      this.InterdectionFumee,
      this.serviceDeChambre,
      this.piscine,
      this.gym,
      this.repasInclus,
      this.wifi,
      this.enfantAutorise,
      this.Parking,
      this.equipe);

  Map toJson() => {
        'InterdectionFumee': InterdectionFumee,
        'serviceDeChambre': serviceDeChambre,
        'piscine': piscine,
        'gym': gym,
        'repasInclus': repasInclus,
        'wifi': wifi,
        'enfantAutorise': enfantAutorise,
        'Parking': Parking,
        'equipe': equipe,
      };

  factory Commodite.fromJson(dynamic json) {
    return Commodite(
      json['InterdectionFumee'] as bool,
      json['serviceDeChambre'] as bool,
      json['piscine'] as bool,
      json['gym'] as bool,
      json['repasInclus'] as bool,
      json['wifi'] as bool,
      json['enfantAutorise'] as bool,
      json['Parking'] as bool,
      json['equipe'] as bool,
    );
  }
}
