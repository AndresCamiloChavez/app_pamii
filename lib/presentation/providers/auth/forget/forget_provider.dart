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
  final String name;
  final String description;
  final String email;
  final String password;
  final Map<String, String?> errors;

  ForgetFormState({
    this.name = '',
    this.description = '',
    this.email = '',
    this.password = '',
    Map<String, String?>? errors,
  }) : errors = errors ?? {};

  ForgetFormState copyWith({
    String? name,
    String? description,
    String? email,
    String? password,
    Map<String, String?>? errors,
  }) {
    return ForgetFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      password: password ?? this.password,
      errors: errors ?? this.errors,
    );
  }
}

class ForgetFormNotifier
    extends StateNotifier<ForgetFormState> {
  final Ref ref;

  ForgetFormNotifier(this.ref) : super(ForgetFormState());

}
