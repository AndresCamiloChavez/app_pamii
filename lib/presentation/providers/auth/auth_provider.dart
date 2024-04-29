

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String? token;

  AuthState({this.token});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void login(String token) {
    state = AuthState(token: token);
  }

  void logout() {
    state = AuthState(token: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
