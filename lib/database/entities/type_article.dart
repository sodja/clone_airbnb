import 'package:floor/floor.dart';

@entity
class TypeArticle {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String titre;
  @ColumnInfo(name: "icon_url")
  final String iconUrl;

  TypeArticle(this.titre, this.iconUrl);
}