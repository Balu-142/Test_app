import '../repositories/chat_repository.dart';
import '../entities/chat_entity.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  Future<List<ChatEntity>> call(String userId) {
    return repository.getChats(userId);
  }
}
