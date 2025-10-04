class ApiConstants {
  static const String baseUrl = 'http://45.129.87.38:6065';

  // Endpoints
  static const String loginUrl = '$baseUrl/user/login';
  static String userChats(String userId) => '$baseUrl/chats/user-chats/$userId';
  static String messages(String chatId) =>
      '$baseUrl/messages/get-messagesformobile/$chatId';
  static String sendMessage = '$baseUrl/messages/sendMessage';



}
