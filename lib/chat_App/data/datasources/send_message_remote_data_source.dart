import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/messages_list_model.dart';
import '../models/send_message_model.dart';

abstract class MessageRemoteDataSource {
  Future<List<MessageListModel>> fetchMessages(String chatId);
  Future<MessageListModel> sendMessage(SendMessageModel message);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final http.Client client;

  MessageRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MessageListModel>> fetchMessages(String chatId) async {
    final url = Uri.parse(ApiConstants.messages(chatId));
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> parsed = json.decode(body);
      return parsed
          .map((jsonItem) => MessageListModel.fromJson(jsonItem))
          .toList();
    } else {
      throw ServerException(
          'Failed to load messages. Status: ${response.statusCode}');
    }
  }

  @override
  Future<MessageListModel> sendMessage(SendMessageModel message) async {
    final url = Uri.parse('http://45.129.87.38:6065/messages/sendMessage');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(message.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = json.decode(response.body);
      return MessageListModel.fromJson(body);
    } else {
      throw ServerException(
          'Failed to send message. Status: ${response.statusCode}');
    }
  }
}