import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/data/repositories/auth/auth_repository.dart';
import 'package:app_pamii/presentation/helpers/loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier(ref);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class LoginFormState {
  final String email;
  final String password;
  final bool isLoginSuccess;
  final String? error;
  final String? alertMessage; // Mensaje para la alerta
  final bool isLoading; // Añadir estado de carga aquí

  LoginFormState({
    this.email = '',
    this.password = '',
    this.error,
    this.isLoginSuccess = false,
    this.alertMessage,
    this.isLoading = false,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    String? error,
    bool? isLoginSuccess,
    String? alertMessage,
    bool? isLoading,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      alertMessage: alertMessage ?? this.alertMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Ref ref;

  LoginFormNotifier(this.ref) : super(LoginFormState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void submitForm(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Hace que el diálogo no se pueda descartar tocando fuera de él
      builder: (BuildContext context) {
        return const LoadingDialog(message: "Iniciando sesión...");
      },
    );

    if (_validateFields(state.email, state.password)) {
      try {
        final isLoggedIn = await ref
            .read(authRepositoryProvider)
            .login(state.email, state.password);
        if (isLoggedIn) {
          state = state.copyWith(isLoginSuccess: true);
          if (mounted) Navigator.of(context).pop();
          ref.read(routerProvider).go('/home');
        } else {
          if (mounted) Navigator.of(context).pop();
          state = state.copyWith(error: 'Invalid credentials');
        }
      } catch (e) {
        if (mounted) Navigator.of(context).pop();
        state = state.copyWith(error: e.toString());
      }
    } else {
      if (mounted) Navigator.of(context).pop();
      state = state.copyWith(error: 'Complete los campos correctamente');
    }
  }

  void clearAlertMessage() {
    state = state.copyWith(
        alertMessage: ''); // Establece el mensaje de alerta a una cadena vacía
  }

  // Método de validación simple
  bool _validateFields(String email, String password) {
    // Implementa aquí las validaciones específicas que necesites
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    if (!email.contains('@')) {
      // Verificación simple de formato de correo
      return false;
    }
    return true;
  }
}
