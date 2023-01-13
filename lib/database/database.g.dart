// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleDao? _articleDaoInstance;

  TypeArticleDao? _typeArticleDaoInstance;

  UserDao? _userDaoInstance;

  MessageDao? _messageDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Article` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_type` TEXT NOT NULL, `property` TEXT NOT NULL, `favorite` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TypeArticle` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `titre` TEXT NOT NULL, `icon_url` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nom` TEXT NOT NULL, `prenom` TEXT NOT NULL, `sexe` TEXT NOT NULL, `date_naissance` TEXT NOT NULL, `telephone` TEXT NOT NULL, `apropos` TEXT NOT NULL, `emplacement` TEXT NOT NULL, `emploi` TEXT NOT NULL, `langues` TEXT NOT NULL, `date_inscription` TEXT NOT NULL, `remoteId` TEXT NOT NULL, `photoUrl` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Message` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date_envoi` TEXT NOT NULL, `id_destinataire` TEXT NOT NULL, `id_expeditaire` TEXT NOT NULL, `message` TEXT, `nom_expeditaire` TEXT, `ville_expeditaire` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleDao get articleDao {
    return _articleDaoInstance ??= _$ArticleDao(database, changeListener);
  }

  @override
  TypeArticleDao get typeArticleDao {
    return _typeArticleDaoInstance ??=
        _$TypeArticleDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }
}

class _$ArticleDao extends ArticleDao {
  _$ArticleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _articleInsertionAdapter = InsertionAdapter(
            database,
            'Article',
            (Article item) => <String, Object?>{
                  'id': item.id,
                  'id_type': item.idType,
                  'property': item.property,
                  'favorite': item.favorite ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Article> _articleInsertionAdapter;

  @override
  Future<List<Article>> findAllArticles() async {
    return _queryAdapter.queryList('SELECT * FROM Article',
        mapper: (Map<String, Object?> row) => Article(
            row['id'] as int?,
            row['id_type'] as String,
            row['property'] as String,
            (row['favorite'] as int) != 0));
  }

  @override
  Future<List<Article>> findAllFavoriteArticles() async {
    return _queryAdapter.queryList('SELECT * FROM Article WHERE favorite = 1',
        mapper: (Map<String, Object?> row) => Article(
            row['id'] as int?,
            row['id_type'] as String,
            row['property'] as String,
            (row['favorite'] as int) != 0));
  }

  @override
  Future<List<Article>> findAllArticlesByIdType(int idType) async {
    return _queryAdapter.queryList('SELECT * FROM Article WHERE idType = ?1',
        mapper: (Map<String, Object?> row) => Article(
            row['id'] as int?,
            row['id_type'] as String,
            row['property'] as String,
            (row['favorite'] as int) != 0),
        arguments: [idType]);
  }

  @override
  Stream<Article?> findArticleById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Article WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Article(
            row['id'] as int?,
            row['id_type'] as String,
            row['property'] as String,
            (row['favorite'] as int) != 0),
        arguments: [id],
        queryableName: 'Article',
        isView: false);
  }

  @override
  Future<int?> updateArticleById(
    int id,
    bool isFavorite,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Article SET favorite = ?2  WHERE id = ?1',
        arguments: [id, isFavorite ? 1 : 0]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Article');
  }

  @override
  Future<void> insertArticle(Article article) async {
    await _articleInsertionAdapter.insert(article, OnConflictStrategy.replace);
  }
}

class _$TypeArticleDao extends TypeArticleDao {
  _$TypeArticleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _typeArticleInsertionAdapter = InsertionAdapter(
            database,
            'TypeArticle',
            (TypeArticle item) => <String, Object?>{
                  'id': item.id,
                  'titre': item.titre,
                  'icon_url': item.iconUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TypeArticle> _typeArticleInsertionAdapter;

  @override
  Future<List<TypeArticle>> findAllTypeArticles() async {
    return _queryAdapter.queryList('SELECT * FROM TypeArticle',
        mapper: (Map<String, Object?> row) =>
            TypeArticle(row['titre'] as String, row['icon_url'] as String));
  }

  @override
  Stream<TypeArticle?> findTypeArticleById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM TypeArticle WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            TypeArticle(row['titre'] as String, row['icon_url'] as String),
        arguments: [id],
        queryableName: 'TypeArticle',
        isView: false);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM TypeArticle');
  }

  @override
  Future<void> insertTypeArticle(TypeArticle typeArticle) async {
    await _typeArticleInsertionAdapter.insert(
        typeArticle, OnConflictStrategy.replace);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'prenom': item.prenom,
                  'sexe': item.sexe,
                  'date_naissance': item.dateNaissance,
                  'telephone': item.telephone,
                  'apropos': item.apropos,
                  'emplacement': item.emplacement,
                  'emploi': item.emploi,
                  'langues': item.langues,
                  'date_inscription': item.dateInscription,
                  'remoteId': item.remoteId,
                  'photoUrl': item.photoUrl
                },
            changeListener),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'prenom': item.prenom,
                  'sexe': item.sexe,
                  'date_naissance': item.dateNaissance,
                  'telephone': item.telephone,
                  'apropos': item.apropos,
                  'emplacement': item.emplacement,
                  'emploi': item.emploi,
                  'langues': item.langues,
                  'date_inscription': item.dateInscription,
                  'remoteId': item.remoteId,
                  'photoUrl': item.photoUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  @override
  Future<List<User>> findAllUser() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            row['id'] as int?,
            row['nom'] as String,
            row['prenom'] as String,
            row['sexe'] as String,
            row['date_naissance'] as String,
            row['telephone'] as String,
            row['apropos'] as String,
            row['emplacement'] as String,
            row['emploi'] as String,
            row['langues'] as String,
            row['date_inscription'] as String,
            row['remoteId'] as String));
  }

  @override
  Stream<User?> findUserById(String phone) {
    return _queryAdapter.queryStream('SELECT * FROM User WHERE telephone = ?1',
        mapper: (Map<String, Object?> row) => User(
            row['id'] as int?,
            row['nom'] as String,
            row['prenom'] as String,
            row['sexe'] as String,
            row['date_naissance'] as String,
            row['telephone'] as String,
            row['apropos'] as String,
            row['emplacement'] as String,
            row['emploi'] as String,
            row['langues'] as String,
            row['date_inscription'] as String,
            row['remoteId'] as String),
        arguments: [phone],
        queryableName: 'User',
        isView: false);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM User');
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateUserById(User user) {
    return _userUpdateAdapter.updateAndReturnChangedRows(
        user, OnConflictStrategy.abort);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _messageInsertionAdapter = InsertionAdapter(
            database,
            'Message',
            (Message item) => <String, Object?>{
                  'id': item.id,
                  'date_envoi': item.dateEnvoi,
                  'id_destinataire': item.idDestinataire,
                  'id_expeditaire': item.idExpeditaire,
                  'message': item.message,
                  'nom_expeditaire': item.nomExpeditaire,
                  'ville_expeditaire': item.villeExpeditaire
                }),
        _messageUpdateAdapter = UpdateAdapter(
            database,
            'Message',
            ['id'],
            (Message item) => <String, Object?>{
                  'id': item.id,
                  'date_envoi': item.dateEnvoi,
                  'id_destinataire': item.idDestinataire,
                  'id_expeditaire': item.idExpeditaire,
                  'message': item.message,
                  'nom_expeditaire': item.nomExpeditaire,
                  'ville_expeditaire': item.villeExpeditaire
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Message> _messageInsertionAdapter;

  final UpdateAdapter<Message> _messageUpdateAdapter;

  @override
  Future<List<Message>> findAllMessage() async {
    return _queryAdapter.queryList('SELECT * FROM Message',
        mapper: (Map<String, Object?> row) => Message(
            row['id'] as int?,
            row['date_envoi'] as String,
            row['id_destinataire'] as String,
            row['id_expeditaire'] as String,
            row['message'] as String?,
            row['nom_expeditaire'] as String?,
            row['ville_expeditaire'] as String?));
  }

  @override
  Future<List<Message>> findMessageByUser(
    String idDest,
    String idExp,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Message WHERE (id_destinataire = ?1 AND id_expeditaire = ?2) OR (id_destinataire = ?2 AND id_expeditaire = ?1)',
        mapper: (Map<String, Object?> row) => Message(row['id'] as int?, row['date_envoi'] as String, row['id_destinataire'] as String, row['id_expeditaire'] as String, row['message'] as String?, row['nom_expeditaire'] as String?, row['ville_expeditaire'] as String?),
        arguments: [idDest, idExp]);
  }

  @override
  Future<List<Message>> findMessageByIdDestinataire(String idDest) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Message WHERE id_destinataire = ?1 GROUP BY id_expeditaire',
        mapper: (Map<String, Object?> row) => Message(row['id'] as int?, row['date_envoi'] as String, row['id_destinataire'] as String, row['id_expeditaire'] as String, row['message'] as String?, row['nom_expeditaire'] as String?, row['ville_expeditaire'] as String?),
        arguments: [idDest]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Message');
  }

  @override
  Future<void> insertMessage(Message message) async {
    await _messageInsertionAdapter.insert(message, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateMessage(Message message) {
    return _messageUpdateAdapter.updateAndReturnChangedRows(
        message, OnConflictStrategy.abort);
  }
}
