

import '../entities/message_entity.dart';
import '../entities/send_message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> getMessages(String chatId);
  Future<MessageEntity> sendMessage(SendMessageEntity message);
}