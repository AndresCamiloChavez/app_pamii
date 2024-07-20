import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/data/repositories/auth/auth_repository.dart';
import 'package:app_pamii/domain/entities/company/company.request.dart';
import 'package:app_pamii/presentation/helpers/loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerCompanyFormProvider = StateNotifierProvider<
    RegisterCompanyFormNotifier, RegisterCompanyFormState>((ref) {
  return RegisterCompanyFormNotifier(ref);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class RegisterCompanyFormState {
  final String name;
  final String description;
  final String email;
  final String password;
  final Map<String, String?> errors;

  RegisterCompanyFormState({
    this.name = '',
    this.description = '',
    this.email = '',
    this.password = '',
    Map<String, String?>? errors,
  }) : errors = errors ?? {};

  RegisterCompanyFormState copyWith({
    String? name,
    String? description,
    String? email,
    String? password,
    Map<String, String?>? errors,
  }) {
    return RegisterCompanyFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      password: password ?? this.password,
      errors: errors ?? this.errors,
    );
  }
}

class RegisterCompanyFormNotifier
    extends StateNotifier<RegisterCompanyFormState> {
  final Ref ref;

  RegisterCompanyFormNotifier(this.ref) : super(RegisterCompanyFormState());

  void updateName(String value) {
    state = state.copyWith(name: value);
    validatename(value);
  }

  void updateDescription(String value) {
    state = state.copyWith(description: value);
    validateDescription(value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
    validateEmail(value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
    validatePassword(value);
  }

  void validatename(String value) {
    if (value.isEmpty) {
      state.errors['name'] = 'El nombre del negocio no puede estar vacío';
    } else {
      state.errors['name'] = null;
    }
    state = state.copyWith();
  }

  void validateDescription(String value) {
    if (value.isEmpty) {
      state.errors['description'] = 'La descripción no puede estar vacía';
    } else {
      state.errors['description'] = null;
    }
    state = state.copyWith();
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      state.errors['email'] = 'El correo electrónico no puede estar vacío';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      state.errors['email'] = 'Por favor ingrese un correo válido';
    } else {
      state.errors['email'] = null;
    }
    state = state.copyWith();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      state.errors['password'] = 'La contraseña no puede estar vacía';
    } else if (value.length < 6) {
      state.errors['password'] =
          'La contraseña debe tener al menos 6 caracteres';
    } else {
      state.errors['password'] = null;
    }
    state = state.copyWith();
  }

  Future<void> submitForm(BuildContext context) async {
    // Primero, realiza la validación de cada campo individualmente
    validatename(state.name);
    validateDescription(state.description);
    validateEmail(state.email);
    validatePassword(state.password);

    // Verifica si hay algún error en alguno de los campos
    bool hasErrors = state.errors.values.any((error) => error != null);

    if (hasErrors) {
      // Si hay errores, muestra un SnackBar con un mensaje de error general
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor corrija los errores antes de enviar.'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Detiene la ejecución si hay errores para no proceder al envío
    }

    // Muestra un diálogo de carga mientras se procesa el envío
    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que el diálogo se cierre al tocar fuera
      builder: (BuildContext context) {
        return const LoadingDialog(message: "Registrando Negocio...");
      },
    );

    try {
      // Simula el envío de datos al servidor
      final response = await ref
          .read(authRepositoryProvider)
          .registerCompany(CompanyRequest(
              name: state.name,
              description: state.description,
              password: state.password,
              email: state.email));
      Navigator.of(context).pop(); // Cierra el diálogo de carga

      if (!response.isFailure) {
        // Si el registro es exitoso, navega a la página principal o de bienvenida
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro completado con éxito.'),
            backgroundColor: Colors.green,
          ),
        );
        ref.read(routerProvider).go('/home');
      } else {
        // Si el registro falla por algún motivo, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.messageError ?? "Error al registrar negocio"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Captura excepciones de la llamada de red o del servidor
      Navigator.of(context).pop(); // Asegúrate de cerrar el diálogo de carga
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error de registro: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
