import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String nom;
  String prenom;
  String sexe;
  @ColumnInfo(name: "date_naissance")
  String dateNaissance;
  String telephone;
  String apropos;
  String emplacement;
  String emploi;
  String langues;
  @ColumnInfo(name: "date_inscription")
  String dateInscription;
  String remoteId;
  String? photoUrl;

  User(this.id,this.nom, this.prenom, this.sexe, this.dateNaissance, this.telephone,
      this.apropos, this.emplacement, this.emploi, this.langues, this.dateInscription, this.remoteId);
}