import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/chat_list_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatListModel>> fetchUserChats(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;

  ChatRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ChatListModel>> fetchUserChats(String userId) async {
    final url = Uri.parse(ApiConstants.userChats(userId));
    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> parsed = json.decode(body);
      return parsed
          .map((jsonItem) => ChatListModel.fromJson(jsonItem))
          .toList();
    } else {
      throw ServerException('Failed to fetch chats: ${response.statusCode}');
    }
  }
}
