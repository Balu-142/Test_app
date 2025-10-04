import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/network_info.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/chat_list_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remote;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<List<ChatEntity>> getChats(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remote.fetchUserChats(userId);
        // convert to entities
        return models.map((m) {
          final participants = m.participants
              ?.map((p) => Attendant(
            id: p.sId ?? '',
            name: p.name ?? '',
            isOnline: p.isOnline ?? false,
          ))
              .toList() ??
              [];
          return ChatEntity(
            id: m.sId ?? '',
            isGroup: m.isGroupChat ?? false,
            attendants: participants,
            lastMessageContent: m.lastMessage?.content,
          );
        }).toList();
      } on ServerException catch (e) {
        throw Failure(message: e.message);
      }
    } else {
      throw Failure(message: 'No internet connection');
    }
  }
}
