import '../entities/message_entity.dart';
import '../entities/send_message_entity.dart';
import '../repositories/message_repository.dart';

class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase(this.repository);

  Future<MessageEntity> call(SendMessageEntity message) {
    return repository.sendMessage(message);
  }
}