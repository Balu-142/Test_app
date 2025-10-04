class ChatListModel {
  String? sId;
  bool? isGroupChat;
  List<Participants>? participants;
  String? createdAt;
  String? updatedAt;
  int? iV;
  LastMessage? lastMessage;

  ChatListModel({
    this.sId,
    this.isGroupChat,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastMessage,
  });

  ChatListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isGroupChat = json['isGroupChat'];
    if (json['participants'] != null) {
      participants = (json['participants'] as List)
          .map((v) => Participants.fromJson(v))
          .toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastMessage = json['lastMessage'] != null
        ? LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'isGroupChat': isGroupChat,
      'participants': participants?.map((v) => v.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'lastMessage': lastMessage?.toJson(),
    };
  }
}

class Participants {
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? phone;
  String? addressLane1;
  String? addressLane2;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  bool? isOnline;
  List<dynamic>? blockedUsers; // originally List<Null>
  String? role;
  bool? isVerified;
  bool? isDeleted;
  String? deletedMessage;
  bool? isDisabled;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastSeen;
  String? plan;
  String? profile;
  List<PaymentHistory>? paymentHistory;
  String? createdForTTL;
  String? deletedTime;
  String? previousPlan;
  String? referralCode;
  String? planEndDate;
  List<String>? fcmTokens;

  Participants({
    this.location,
    this.sId,
    this.name,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.addressLane1,
    this.addressLane2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isOnline,
    this.blockedUsers,
    this.role,
    this.isVerified,
    this.isDeleted,
    this.deletedMessage,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastSeen,
    this.plan,
    this.profile,
    this.paymentHistory,
    this.createdForTTL,
    this.deletedTime,
    this.previousPlan,
    this.referralCode,
    this.planEndDate,
    this.fcmTokens,
  });

  Participants.fromJson(Map<String, dynamic> json) {
    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    phone = json['phone'];
    addressLane1 = json['addressLane1'];
    addressLane2 = json['addressLane2'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
    isOnline = json['isOnline'];
    blockedUsers = json['blockedUsers'];
    role = json['role'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    deletedMessage = json['deletedMessage'];
    isDisabled = json['isDisabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastSeen = json['lastSeen'];
    plan = json['plan'];
    profile = json['profile'];

    if (json['paymentHistory'] != null) {
      paymentHistory = (json['paymentHistory'] as List)
          .map((v) => PaymentHistory.fromJson(v))
          .toList();
    }

    createdForTTL = json['createdForTTL'];
    deletedTime = json['deletedTime'];
    previousPlan = json['previousPlan'];
    referralCode = json['referralCode'];
    planEndDate = json['planEndDate'];
    fcmTokens = (json['fcmTokens'] as List<dynamic>?)
        ?.map((token) => token.toString())
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      '_id': sId,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'phone': phone,
      'addressLane1': addressLane1,
      'addressLane2': addressLane2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'isOnline': isOnline,
      'blockedUsers': blockedUsers,
      'role': role,
      'isVerified': isVerified,
      'isDeleted': isDeleted,
      'deletedMessage': deletedMessage,
      'isDisabled': isDisabled,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'lastSeen': lastSeen,
      'plan': plan,
      'profile': profile,
      'paymentHistory': paymentHistory?.map((v) => v.toJson()).toList(),
      'createdForTTL': createdForTTL,
      'deletedTime': deletedTime,
      'previousPlan': previousPlan,
      'referralCode': referralCode,
      'planEndDate': planEndDate,
      'fcmTokens': fcmTokens,
    };
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PaymentHistory {
  String? orderId;
  int? amount;
  String? currency;
  String? status;
  Method? method;
  String? paidAt;
  String? sId;

  PaymentHistory({
    this.orderId,
    this.amount,
    this.currency,
    this.status,
    this.method,
    this.paidAt,
    this.sId,
  });

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    paidAt = json['paidAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'method': method?.toJson(),
      'paidAt': paidAt,
      '_id': sId,
    };
  }
}

class Method {
  Upi? upi;

  Method({this.upi});

  Method.fromJson(Map<String, dynamic> json) {
    upi = json['upi'] != null ? Upi.fromJson(json['upi']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'upi': upi?.toJson(),
    };
  }
}

class Upi {
  String? channel;
  String? upiId;

  Upi({this.channel, this.upiId});

  Upi.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'upi_id': upiId,
    };
  }
}

class LastMessage {
  String? sId;
  String? senderId;
  String? content;
  String? messageType;
  String? fileUrl;
  String? createdAt;

  LastMessage({
    this.sId,
    this.senderId,
    this.content,
    this.messageType,
    this.fileUrl,
    this.createdAt,
  });

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'];
    content = json['content'];
    messageType = json['messageType'];
    fileUrl = json['fileUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'fileUrl': fileUrl,
      'createdAt': createdAt,
    };
  }
}
