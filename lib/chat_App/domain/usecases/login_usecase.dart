import '../repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel> call({
    required String email,
    required String password,
    required String role,
  }) {
    return repository.login(email: email, password: password, role: role);
  }
}
