import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import '../../domain/entities/chat_entity.dart';
import '../../core/errors/failures.dart';

abstract class ChatListEvent {}

class LoadChats extends ChatListEvent {
  final String userId;
  LoadChats({required this.userId});
}

abstract class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<ChatEntity> chats;
  ChatListLoaded(this.chats);
}

class ChatListError extends ChatListState {
  final String message;
  ChatListError(this.message);
}

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatsUseCase getChats;

  ChatListBloc({required this.getChats}) : super(ChatListInitial()) {
    on<LoadChats>((event, emit) async {
      emit(ChatListLoading());
      try {
        final chats = await getChats(event.userId);
        emit(ChatListLoaded(chats));
      } catch (e) {
        String msg = 'Unknown error';
        if (e is Failure) {
          msg = e.message;
        } else {
          msg = e.toString();
        }
        emit(ChatListError(msg));
      }
    });
  }
}
