import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
    required String role,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.login(email: email, password: password, role: role);
      } on ServerException catch (e) {
        throw Failure(message: e.message);
      }
    } else {
      throw Failure(message: 'No internet connection');
    }
  }
}
