import 'package:airbnb_clone/database/entities/article.dart';
import 'package:airbnb_clone/database/entities/utilisateur.dart';
import 'package:airbnb_clone/models/user_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao{
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUser();

  @Query('SELECT * FROM User WHERE telephone = :phone')
  Stream<User?> findUserById(String phone);

  @Update()
  Future<int?> updateUserById(User user);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(User user);

  @Query('DELETE FROM User')
  Future<void> deleteAll();
}