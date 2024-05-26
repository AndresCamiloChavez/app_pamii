
import 'package:app_pamii/core/network/error_response.dart';
import 'package:app_pamii/data/repositories/auth/auth_repository.dart';

class AuthenticateUser {
  final AuthRepository _authRepository;

  AuthenticateUser(this._authRepository);

  Future<ResponsePamii> call(String email, String password) async {
    try {
      return await _authRepository.login(email, password);
    } catch (e) {

      //!Manejar errores
      throw Exception('Failed to authenticate');
    }
  }
}