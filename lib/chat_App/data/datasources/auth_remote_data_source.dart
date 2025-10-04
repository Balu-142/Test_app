// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../core/constants/api_constants.dart';
// import '../../core/errors/exceptions.dart';
// import '../models/user_model.dart';
//
// abstract class AuthRemoteDataSource {
//   Future<UserModel> login({
//     required String email,
//     required String password,
//     required String role,
//   });
// }
//
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final http.Client client;
//
//   AuthRemoteDataSourceImpl({required this.client});
//
//   @override
//   Future<UserModel> login({
//     required String email,
//     required String password,
//     required String role,
//   }) async {
//     final url = Uri.parse(ApiConstants.loginUrl);
//     final response = await client.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'email': email,
//         'password': password,
//         'role': role,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final jsonMap = json.decode(response.body);
//       return UserModel.fromJson(jsonMap);
//     } else {
//       throw ServerException('Failed to login');
//     }
//   }
// }




import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
    required String role,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});


  @override
  Future<UserModel> login({
    required String email,
    required String password,
    required String role,
  }) async {
    print('Login called with email: "$email"');
    print('Login called with password: "$password"');
    print('Login called with role: "$role"');

    final cleanedEmail = email.trim();
    final cleanedRole = role.trim().toLowerCase();

    final url = Uri.parse(ApiConstants.loginUrl);

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': cleanedEmail,
          'password': password,
          'role': cleanedRole,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        print('Parsed JSON: $jsonMap');
        return UserModel.fromJson(jsonMap);
      } else {
        String errorMessage = 'Failed to login';
        try {
          final errorJson = json.decode(response.body);
          if (errorJson is Map && errorJson.containsKey('msg')) {
            errorMessage = errorJson['msg'];
          }
        } catch (_) {}
        print('Error: $errorMessage');
        throw ServerException(errorMessage);
      }
    } catch (e, stacktrace) {
      print('Exception caught: $e');
      print('Stacktrace: $stacktrace');
      throw ServerException('Failed to login: $e');
    }
  }


}
