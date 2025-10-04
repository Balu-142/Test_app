import '../entities/message_entity.dart';

abstract class ChatMessagesRepository {
  Future<List<MessageEntity>> getMessages(String chatId);

  Future<MessageEntity> sendMessage({
    required String chatId,
    required String senderId,
    required String content,
    required String messageType,
    String? fileUrl,
  });
}
