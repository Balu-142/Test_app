class MessageListModel {
  String? sId;
  String? chatId;
  String? senderId;
  String? content;
  String? messageType;
  List<String>? deletedBy;
  String? status;
  String? deliveredAt;
  String? seenAt;
  List<String>? seenBy;
  List<String>? reactions;
  String? sentAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MessageListModel({
    this.sId,
    this.chatId,
    this.senderId,
    this.content,
    this.messageType,
    this.deletedBy,
    this.status,
    this.deliveredAt,
    this.seenAt,
    this.seenBy,
    this.reactions,
    this.sentAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) {
    return MessageListModel(
      sId: json['_id'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      content: json['content'],
      messageType: json['messageType'],
      deletedBy: json['deletedBy'] != null
          ? List<String>.from(json['deletedBy'])
          : null,
      status: json['status'],
      deliveredAt: json['deliveredAt'],
      seenAt: json['seenAt'],
      seenBy: json['seenBy'] != null
          ? List<String>.from(json['seenBy'])
          : null,
      reactions: json['reactions'] != null
          ? List<String>.from(json['reactions'])
          : null,
      sentAt: json['sentAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'deletedBy': deletedBy,
      'status': status,
      'deliveredAt': deliveredAt,
      'seenAt': seenAt,
      'seenBy': seenBy,
      'reactions': reactions,
      'sentAt': sentAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}
