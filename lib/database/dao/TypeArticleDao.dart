import 'package:airbnb_clone/database/entities/article.dart';
import 'package:floor/floor.dart';

import '../entities/type_article.dart';

@dao
abstract class TypeArticleDao{
  @Query('SELECT * FROM TypeArticle')
  Future<List<TypeArticle>> findAllTypeArticles();

  @Query('SELECT * FROM TypeArticle WHERE id = :id')
  Stream<TypeArticle?> findTypeArticleById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTypeArticle(TypeArticle typeArticle);

  @Query('DELETE FROM TypeArticle')
  Future<void> deleteAll();
}