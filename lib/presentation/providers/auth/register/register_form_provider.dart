import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/data/repositories/auth/auth_repository.dart';
import 'package:app_pamii/domain/entities/user.request.dart';
import 'package:app_pamii/presentation/helpers/loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier(ref);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class RegisterFormState {
  final String firstName;
  final String lastName;
  final String phone;
  final String birthDay;
  final String email;
  final String password;
  final String? error; // Opcional, para manejar mensajes de error
  final bool isLoading; // Para indicar cuando se está procesando algo

  RegisterFormState({
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.birthDay = '',
    this.email = '',
    this.password = '',
    this.error,
    this.isLoading = false,
  });

  RegisterFormState copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? birthDay,
    String? email,
    String? password,
    String? error,
    bool? isLoading,
  }) {
    return RegisterFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      birthDay: birthDay ?? this.birthDay,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Ref ref;
  RegisterFormNotifier(this.ref) : super(RegisterFormState());

  void updateName(String firstName) =>
      state = state.copyWith(firstName: firstName);
  void updateLastName(String lastName) =>
      state = state.copyWith(lastName: lastName);
  void updatePhone(String phone) => state = state.copyWith(phone: phone);
  void updateBirthDay(String birthDay) =>
      state = state.copyWith(birthDay: birthDay);
  void updateEmail(String email) => state = state.copyWith(email: email);
  void updatePassword(String password) =>
      state = state.copyWith(password: password);

  bool _validateFields() {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    RegExp phoneRegex =
        RegExp(r'^\d{10}$'); // Ajusta según el formato de teléfono esperado
    RegExp dateRegex =
        RegExp(r'^\d{4}-\d{2}-\d{2}$'); // Formato de fecha YYYY-MM-DD
    RegExp nameRegex = RegExp(r'^[a-zA-Z \-]+$');

    bool isValidName = nameRegex.hasMatch(state.firstName);
    bool isValidLastName = nameRegex.hasMatch(state.lastName);
    bool isValidPhone = phoneRegex.hasMatch(state.phone);
    bool isValidBirthDate = dateRegex.hasMatch(state.birthDay);
    bool isValidEmail = emailRegex.hasMatch(state.email);
    bool isValidPassword = state.password.length >= 8 &&
        state.password.contains(RegExp(r'[0-9]')) &&
        state.password.contains(RegExp(r'[A-Z]')) &&
        state.password.contains(RegExp(r'[a-z]')) &&
        state.password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return isValidName &&
        isValidLastName &&
        isValidPhone &&
        isValidBirthDate &&
        isValidEmail &&
        isValidPassword;
  }

  Future<void> submitForm(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog(message: "Registrando...");
      },
    );

    if (_validateFields()) {
      try {
        final isSuccessRegister = await ref
            .read(authRepositoryProvider)
            .register(UserRequest(
                firstName: state.firstName,
                lastName: state.lastName,
                phone: state.phone,
                password: state.password,
                birthDay: state.birthDay,
                email: state.email));
        print("Resultado ${isSuccessRegister}");
        Navigator.of(context).pop();
        state = state.copyWith(isLoading: false);
        ref
            .read(routerProvider)
            .go('/home'); // Navegar a home o a una pantalla de bienvenida
      } catch (e) {
        Navigator.of(context).pop();
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    } else {
      Navigator.of(context).pop();
      state = state.copyWith(
          error: 'Por favor, completa todos los campos correctamente.');
    }
  }
}
