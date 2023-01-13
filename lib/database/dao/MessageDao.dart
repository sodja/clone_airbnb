import 'package:airbnb_clone/database/entities/article.dart';
import 'package:airbnb_clone/database/entities/utilisateur.dart';
import 'package:airbnb_clone/models/user_model.dart';
import 'package:floor/floor.dart';

import '../entities/message.dart';

@dao
abstract class MessageDao{
  @Query('SELECT * FROM Message')
  Future<List<Message>> findAllMessage();

  @Query('SELECT * FROM Message WHERE (id_destinataire = :idDest AND id_expeditaire = :idExp) OR (id_destinataire = :idExp AND id_expeditaire = :idDest)')
  Future<List<Message>> findMessageByUser(String idDest, String idExp);

  @Query('SELECT * FROM Message WHERE id_destinataire = :idDest GROUP BY id_expeditaire')
  Future<List<Message>> findMessageByIdDestinataire(String idDest);

  @Update()
  Future<int?> updateMessage(Message message);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMessage(Message message);

  @Query('DELETE FROM Message')
  Future<void> deleteAll();
}