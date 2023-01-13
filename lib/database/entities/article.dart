import 'dart:ffi';

import 'package:floor/floor.dart';

@entity
class Article {
  @PrimaryKey(autoGenerate: true)
  int? id;
  @ColumnInfo(name: "id_type")
  final String idType;
  final String property;
  final bool favorite;
  Article(this.id, this.idType, this.property, this.favorite);
}