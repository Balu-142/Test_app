class ChatEntity {
  final String id;
  final bool isGroup;
  final List<Attendant> attendants;
  final String? lastMessageContent;

  ChatEntity({
    required this.id,
    required this.isGroup,
    required this.attendants,
    this.lastMessageContent,
  });
}

class Attendant {
  final String id;
  final String name;
  final bool isOnline;

  Attendant({
    required this.id,
    required this.name,
    required this.isOnline,
  });
}
