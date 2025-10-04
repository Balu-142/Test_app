import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../blocs/message_bloc.dart';
import '../pages/message_page.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatEntity chat;

  const ChatItemWidget({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = chat.attendants.isNotEmpty
        ? chat.attendants.map((a) => a.name).join(', ')
        : 'Unknown';

    final avatarText = title.isNotEmpty ? title[0].toUpperCase() : '?';

    final subtitle = chat.lastMessageContent != null &&
        chat.lastMessageContent!.isNotEmpty
        ? chat.lastMessageContent!
        : 'No messages yet';

    final chatId = chat.id;

    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          avatarText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      onTap: () {
        final getMessagesUseCase =
        RepositoryProvider.of<GetMessagesUseCase>(context);
        final sendMessageUseCase =
        RepositoryProvider.of<SendMessageUseCase>(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider<MessageBloc>(
              create: (ctx) => MessageBloc(
                getMessages: getMessagesUseCase,
                sendMessage: sendMessageUseCase,
              )..add(LoadMessages(chatId: chatId)),
              child: MessagePage(chatId: chatId),
            ),
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dateTime.weekday - 1];
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}