import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/presentation/providers/auth/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class AuthRepository {
  final Dio dio;
  final ProviderRef ref;

  AuthRepository(this.dio, this.ref);

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        ref.read(authProvider.notifier).login(response.data['token']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
