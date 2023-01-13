import 'dart:async';
import 'package:airbnb_clone/database/dao/MessageDao.dart';
import 'package:airbnb_clone/database/entities/article.dart';
import 'package:airbnb_clone/database/entities/type_article.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/ArticleDao.dart';
import 'dao/TypeArticleDao.dart';
import 'dao/UserDao.dart';
import 'entities/message.dart';
import 'entities/utilisateur.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [Article, TypeArticle, User, Message])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
  TypeArticleDao get typeArticleDao;
  UserDao get userDao;
  MessageDao get messageDao;
}