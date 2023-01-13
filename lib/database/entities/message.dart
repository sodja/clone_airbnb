import 'package:floor/floor.dart';

@entity
class Message {
  @PrimaryKey(autoGenerate: true)
  int? id;
  @ColumnInfo(name: "date_envoi")
  String dateEnvoi;
  @ColumnInfo(name: "id_destinataire")
  String idDestinataire;
  @ColumnInfo(name: "id_expeditaire")
  String idExpeditaire;
  String? message;
  @ColumnInfo(name: "nom_expeditaire")
  String? nomExpeditaire;
  @ColumnInfo(name: "ville_expeditaire")
  String? villeExpeditaire;

  Message(this.id, this.dateEnvoi, this.idDestinataire, this.idExpeditaire,
      this.message, this.nomExpeditaire, this.villeExpeditaire);
}