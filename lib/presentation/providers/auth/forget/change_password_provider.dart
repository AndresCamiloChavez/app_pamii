import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/data/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changePasswordProvider = StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  return ChangePasswordNotifier(ref);
});
final forgetAuthRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class ChangePasswordState {
  final String newPassword;
  final String confirmPassword;
  final String? error;
  final bool isLoading;
  final bool isSuccess;

  ChangePasswordState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.error = '',
    this.isLoading = false,
    this.isSuccess = false,
  });

  ChangePasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    String? error,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ChangePasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final Ref ref;

  ChangePasswordNotifier(this.ref) : super(ChangePasswordState());

  void updateNewPassword(String newPassword) {
    state = state.copyWith(newPassword: newPassword);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  Future<void> changePassword(String email) async {
    if (state.newPassword.isEmpty || state.confirmPassword.isEmpty) {
      state = state.copyWith(error: "Both fields are required");
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      state = state.copyWith(error: "Passwords do not match");
      return;
    }

    // Password regex for at least 8 characters, one uppercase, one lowercase, one number and one special character
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    if (!passwordRegex.hasMatch(state.newPassword)) {
      state = state.copyWith(error: "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number and a special character");
      return;
    }

    state = state.copyWith(isLoading: true, error: '');

    try {
      // final response = await ref.read(forgetAuthRepositoryProvider).changePassword(email, state.newPassword);
      // if (response.response?.message != null) {
      //   state = state.copyWith(isSuccess: true, isLoading: false);
      // } else {
      //   state = state.copyWith(isLoading: false, error: "Failed to change password");
      // }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Failed to change password");
    }
  }
}
