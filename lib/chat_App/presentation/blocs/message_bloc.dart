// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/usecases/get_messages_usecase.dart';
// import '../../domain/entities/message_entity.dart';
// import '../../core/errors/failures.dart';
//
// // Events
// abstract class MessageEvent {}
//
// class LoadMessages extends MessageEvent {
//   final String chatId;
//   LoadMessages({required this.chatId});
// }
//
// // States
// abstract class MessageState {}
//
// class MessageInitial extends MessageState {}
//
// class MessageLoading extends MessageState {}
//
// class MessageLoaded extends MessageState {
//   final List<MessageEntity> messages;
//   MessageLoaded(this.messages);
// }
//
// class MessageError extends MessageState {
//   final String message;
//   MessageError(this.message);
// }
//
// // Bloc
// class MessageBloc extends Bloc<MessageEvent, MessageState> {
//   final GetMessagesUseCase getMessages;
//
//   MessageBloc({required this.getMessages}) : super(MessageInitial()) {
//     on<LoadMessages>((event, emit) async {
//       emit(MessageLoading());
//       try {
//         final msgs = await getMessages(event.chatId);
//         emit(MessageLoaded(msgs));
//       } catch (e) {
//         String msg = 'Unknown error';
//         if (e is Failure) {
//           msg = e.message;
//         } else {
//           msg = e.toString();
//         }
//         emit(MessageError(msg));
//       }
//     });
//   }
// }



import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/send_message_entity.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';

abstract class MessageEvent {}

class LoadMessages extends MessageEvent {
  final String chatId;
  LoadMessages({required this.chatId});
}

class SendMessage extends MessageEvent {
  final SendMessageEntity message;
  SendMessage({required this.message});
}


abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageEntity> messages;
  MessageLoaded({required this.messages});
}

class MessageSending extends MessageState {
  final List<MessageEntity> messages;
  MessageSending({required this.messages});
}

class MessageSent extends MessageState {
  final List<MessageEntity> messages;
  MessageSent({required this.messages});
}

class MessageError extends MessageState {
  final String message;
  MessageError({required this.message});
}

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesUseCase getMessages;
  final SendMessageUseCase sendMessage;

  MessageBloc({
    required this.getMessages,
    required this.sendMessage,
  }) : super(MessageInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadMessages(
      LoadMessages event,
      Emitter<MessageState> emit,
      ) async {
    emit(MessageLoading());
    try {
      final messages = await getMessages(event.chatId);
      emit(MessageLoaded(messages: messages));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event,
      Emitter<MessageState> emit,
      ) async {
    final currentState = state;
    List<MessageEntity> currentMessages = [];

    if (currentState is MessageLoaded) {
      currentMessages = currentState.messages;
    } else if (currentState is MessageSent) {
      currentMessages = currentState.messages;
    }

    emit(MessageSending(messages: currentMessages));

    try {
      final newMessage = await sendMessage(event.message);
      final updatedMessages = [...currentMessages, newMessage];
      emit(MessageSent(messages: updatedMessages));
    } catch (e) {
      emit(MessageError(message: e.toString()));
      emit(MessageLoaded(messages: currentMessages));
    }
  }
}