import 'package:airbnb_clone/database/entities/article.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao{
  @Query('SELECT * FROM Article')
  Future<List<Article>> findAllArticles();

  @Query('SELECT * FROM Article WHERE favorite = 1')
  Future<List<Article>> findAllFavoriteArticles();

  @Query('SELECT * FROM Article WHERE idType = :idType')
  Future<List<Article>> findAllArticlesByIdType(int idType);

  @Query('SELECT * FROM Article WHERE id = :id')
  Stream<Article?> findArticleById(int id);

  @Query('UPDATE Article SET favorite = :isFavorite  WHERE id = :id')
  Future<int?> updateArticleById(int id, bool isFavorite);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(Article article);

  @Query('DELETE FROM Article')
  Future<void> deleteAll();
}