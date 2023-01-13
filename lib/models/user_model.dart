
import '../database/entities/utilisateur.dart';
import '../database/entities/utilisateur.dart';

class UserModel {
  String? id;
  String? nom;
  String? prenom;
  String? sexe;
  String? dateNaissance;
  String? telephone;
  String? apropos;
  String? emplacement;
  String? emploi;
  String? langues;
  String? dateInscription;
  String? remoteId;
  String? photoUrl;
  int? entityId;
  late String? email;

  UserModel({
    this.id,
    required this.nom,
    this.prenom,
    this.sexe,
    this.dateNaissance,
    this.telephone,
    this.apropos,
    this.emplacement,
    this.emploi,
    this.langues,
    this.dateInscription,
    this.email,
  });

  User toEntity() {
    var entity = User(entityId, nom!, prenom!, sexe!, dateNaissance!, telephone!,
        apropos!, emplacement!, emploi!, langues!, dateInscription!, remoteId!);
    entity.photoUrl = photoUrl;
    return entity;
  }

  factory UserModel.fromEntity(User user){
    var userModel = UserModel(nom: user.nom, apropos: user.apropos, emploi: user.emploi,
    dateInscription: user.dateInscription, dateNaissance: user.dateNaissance,
    prenom: user.prenom, sexe: user.sexe, emplacement: user.emplacement,
    langues: user.langues, telephone: user.telephone);
    userModel.remoteId = user.remoteId;
    userModel.photoUrl = user.photoUrl;
    userModel.entityId = user.id;
    return userModel;
  }
}


