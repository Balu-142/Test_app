class SendMessageEntity {
  final String chatId;
  final String senderId;
  final String content;
  final String messageType;
  final String? fileUrl;

  SendMessageEntity({
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.messageType,
    this.fileUrl,
  });
}