class SendMessageModel {
  String? chatId;
  String? senderId;
  String? content;
  String? messageType;
  String? fileUrl;
  List<String>? deletedBy;
  String? status;
  String? deliveredAt;
  String? seenAt;
  List<String>? seenBy;
  String? sId;
  List<String>? reactions;
  String? sentAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SendMessageModel({
    this.chatId,
    this.senderId,
    this.content,
    this.messageType,
    this.fileUrl,
    this.deletedBy,
    this.status,
    this.deliveredAt,
    this.seenAt,
    this.seenBy,
    this.sId,
    this.reactions,
    this.sentAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    return SendMessageModel(
      chatId: json['chatId'],
      senderId: json['senderId'],
      content: json['content'],
      messageType: json['messageType'],
      fileUrl: json['fileUrl'],
      deletedBy: json['deletedBy'] != null
          ? List<String>.from(json['deletedBy'])
          : null,
      status: json['status'],
      deliveredAt: json['deliveredAt'],
      seenAt: json['seenAt'],
      seenBy: json['seenBy'] != null
          ? List<String>.from(json['seenBy'])
          : null,
      sId: json['_id'],
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
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'fileUrl': fileUrl,
      'deletedBy': deletedBy,
      'status': status,
      'deliveredAt': deliveredAt,
      'seenAt': seenAt,
      'seenBy': seenBy,
      '_id': sId,
      'reactions': reactions,
      'sentAt': sentAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}
