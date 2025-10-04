class MessageEntity {
  final String id;
  final String senderId;
  final String content;
  final String? messageType;
  final String? sentAt;

  MessageEntity({
    required this.id,
    required this.senderId,
    required this.content,
    this.messageType,
    this.sentAt,
  });
}
