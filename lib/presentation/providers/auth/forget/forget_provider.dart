import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/data/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgetFormProvider =
    StateNotifierProvider<ForgetFormNotifier, ForgetFormState>((ref) {
  return ForgetFormNotifier(ref);
});

final forgetAuthRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class ForgetFormState {
  final String email;
  final String? error;
  final bool isLoading;
  final bool isSuccess;
  final bool isCodeVerified;
  final String securityCode;
  final bool isVerificationError;

  ForgetFormState({
    this.email = '',
    this.error = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.isCodeVerified = false,
    this.isVerificationError = false,
    this.securityCode = '',
  });

  ForgetFormState copyWith({
    String? email,
    String? error,
    bool? isLoading,
    bool? isSuccess,
    bool? isCodeVerified,
    String? securityCode,
    bool? isVerificationError,
  }) {
    return ForgetFormState(
        email: email ?? this.email,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isCodeVerified: isCodeVerified ?? this.isCodeVerified,
        isVerificationError: isVerificationError ?? this.isVerificationError,
        securityCode: securityCode ?? this.securityCode);
  }
}

class ForgetFormNotifier extends StateNotifier<ForgetFormState> {
  final Ref ref;

  ForgetFormNotifier(this.ref) : super(ForgetFormState());

  void updateEmail(String email) {
    state = state.copyWith(email: email, isSuccess: false, isLoading: false);
  }

  void updateSecurityCode(String code) {
    state = state.copyWith(securityCode: code);
  }

  Future<void> sendCodeRecovery() async {
    if (state.email.isEmpty) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final codeSuccess = await ref
          .read(forgetAuthRepositoryProvider)
          .sendCodeRecover(state.email);
      if (codeSuccess.response?.message != null) {
        state = state.copyWith(isSuccess: true, isLoading: false);
      } else {
        state = state.copyWith(
            isLoading: false, error: "Error al enviar el código");
      }
    } catch (e) {
      state =
          state.copyWith(isLoading: false, error: "Error al enviar el código");
    }
  }

  Future<void> verificationCodeRecovery() async {
    if (state.securityCode.isEmpty) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final codeSuccess = await ref
          .read(forgetAuthRepositoryProvider)
          .verificationCodeRecover(state.email, state.securityCode);
      if (codeSuccess.response?.message != null) {
        state = state.copyWith(isCodeVerified: true, isLoading: false);
      } else {
        state = state.copyWith(
            isLoading: false,
            isVerificationError: true,
            error: "Código inválido");
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          isVerificationError: true,
          error: "Ocurrió un error con el código");
    }
  }

  void resetSuccess() {
    state = state.copyWith(isSuccess: false);
  }
}
