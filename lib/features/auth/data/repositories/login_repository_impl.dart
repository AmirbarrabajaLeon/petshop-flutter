import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/auth_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthService authService;

  LoginRepositoryImpl(this.authService);

  @override
  Future<User> login(String email, String password) async {
    return await authService.login(email, password);
  }
}
