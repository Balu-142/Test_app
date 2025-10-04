import '../repositories/message_repository.dart';
import '../entities/message_entity.dart';

class GetMessagesUseCase {
  final MessageRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<MessageEntity>> call(String chatId) {
    return repository.getMessages(chatId);
  }
}
