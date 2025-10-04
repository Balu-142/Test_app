import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/network_info.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/send_message_entity.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';
import '../models/send_message_model.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remote;
  final NetworkInfo networkInfo;

  MessageRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<List<MessageEntity>> getMessages(String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remote.fetchMessages(chatId);
        return models.map((m) {
          return MessageEntity(
            id: m.sId ?? '',
            senderId: m.senderId ?? '',
            content: m.content ?? '',
            messageType: m.messageType,
            sentAt: m.sentAt,
          );
        }).toList();
      } on ServerException catch (e) {
        throw Failure(message: e.message);
      }
    } else {
      throw Failure(message: 'No internet connection');
    }
  }

  @override
  Future<MessageEntity> sendMessage(SendMessageEntity message) async {
    if (await networkInfo.isConnected) {
      try {
        final model = SendMessageModel(
          chatId: message.chatId,
          senderId: message.senderId,
          content: message.content,
          messageType: message.messageType,
          fileUrl: message.fileUrl,
        );

        final result = await remote.sendMessage(model);

        return MessageEntity(
          id: result.sId ?? '',
          senderId: result.senderId ?? '',
          content: result.content ?? '',
          messageType: result.messageType,
          sentAt: result.sentAt,
        );
      } on ServerException catch (e) {
        throw Failure(message: e.message);
      }
    } else {
      throw Failure(message: 'No internet connection');
    }
  }
}