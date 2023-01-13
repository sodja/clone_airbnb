import 'dart:convert';

import 'package:airbnb_clone/database/entities/article.dart';
import 'package:airbnb_clone/database/entities/utilisateur.dart';
import 'package:airbnb_clone/models/Appartement.dart';
import 'package:airbnb_clone/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../database/database.dart';
import '../database/entities/message.dart';
import '../database/entities/type_article.dart';
import '../models/Address.dart';
import '../models/Hotel.dart';
import '../models/Property.dart';
import '../models/message_model.dart';

class DataBaseService extends GetxService{
  late AppDatabase database;


  Future test() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final articleDao = database.articleDao;
    final typeArticleDao = database.typeArticleDao;
    final type0 =   TypeArticle("All", "0xe061");
    final type =   TypeArticle("hotel", "0xeda3");
    final type1 =   TypeArticle("appartement", "0xf07dd");
    final hotel = Hotel(
      "hotel",
      ['assets/images/properties/p1.jpg', "assets/images/properties/p2.jpg"],
      5000,
      Address("Niamey", "Niger", "Boufarik", "el mo9rani", "15", "09025"),
      "description  qui peut depasser 3 lignes donc la suite sera cachée until clicking the button afficher la suite pour l'afficher. voici une démonstration qui le fait ",
      5,
      Commodite(
          true,
          true,
          false,
          true,
          true,
          true,
          true,
          true,
          true),
      true,
      false,
      true,
        "14.725441961477317",
        " -17.50399456535964",
      "PFq4d2H05HM7zaalGL0CetObNYl1"
    ).toJson();
    String hotelJson = jsonEncode(hotel);
    final appart = Appartement(
      "appartement",
      ['assets/images/properties/p3.jpg', "assets/images/properties/p2.jpg"],
      2500,
      Address("Sénégal", "Dakar", "Reghaia", "el hadad", "55", "16025"),
      "description  qui peut depasser 3 lignes donc la suite sera cachée until clicking the button afficher la suite pour l'afficher. voici une démonstration qui le fait ",
      4.0,
      Commodite(
          true,
          true,
          false,
          true,
          true,
          true,
          true,
          true,
          true),
      true,
      false,
      true,
        "14.72719560925123",
        "-17.505201499742366",
      "PFq4d2H05HM7zaalGL0CetObNYl1"
    );
    String appartJson = jsonEncode(appart);


    final article = Article(null,"hotel", hotelJson, false);
    final article2 = Article(null, "appartement", appartJson, false);
    await typeArticleDao.insertTypeArticle(type0);
    await typeArticleDao.insertTypeArticle(type);
    await typeArticleDao.insertTypeArticle(type1);
    await articleDao.insertArticle(article);
    await articleDao.insertArticle(article2);
    return true;
  }

  Future deleteAll() async{
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final articleDao = database.articleDao;
    final typeArticleDao = database.typeArticleDao;
    final messageDao = database.messageDao;

    await messageDao.deleteAll();
    await articleDao.deleteAll();
    await typeArticleDao.deleteAll();
  }

  Future deleteAllType() async{
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final typeArticleDao = database.typeArticleDao;

    await typeArticleDao.deleteAll();
  }

  Future<List<Article>> getAllArticle() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final articleDao = database.articleDao;
    return articleDao.findAllArticles();
  }


  Future<List<Article>> getAllFavoritesArticle() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final articleDao = database.articleDao;
    return articleDao.findAllFavoriteArticles();
  }

  Future<List<TypeArticle>> getAllTypeArticle() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final typeArticleDao = database.typeArticleDao;
    return typeArticleDao.findAllTypeArticles();
  }

  Future<List<Message>> getAllMessageByUser(String userId) async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final messageDao = database.messageDao;
    return messageDao.findMessageByIdDestinataire(userId);
  }

  Future<List<Message>> getAllMessageByIdDestAndIdExp(String idDest, String idExp) async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final messageDao = database.messageDao;
    return messageDao.findMessageByUser(idDest, idExp);
  }

  Future<int?> updateArticleById(int id, bool isFavorite) async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final articleDao = database.articleDao;
    return articleDao.updateArticleById(id, isFavorite);
  }

  Future<void> insertUser(UserModel userModel) async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    var userEntity = userModel.toEntity();
    return userDao.insertUser(userEntity);
  }

  Future insertMessage(MessageModel messageModel) async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final messageDao = database.messageDao;
    var messageEntity = messageModel.toEntity();
    return messageDao.insertMessage(messageEntity);
  }


  Future<List<User>> getUserInfos() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    return userDao.findAllUser();
  }

  Future<int?> updateUser(UserModel userModel) async {
    print(userModel.entityId);
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    var userEntity = userModel.toEntity();
    print(userEntity.id);
    return userDao.updateUserById(userEntity);
  }

}