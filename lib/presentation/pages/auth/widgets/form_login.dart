import 'package:app_pamii/core/constants/colors.dart';
import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(loginFormProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(loginFormProvider.notifier).updateEmail(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Correo electrónico',
                errorText: formData.error,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextField(
            style: const TextStyle(
                color: Colors.white),
            onChanged: (value) =>
                ref.read(loginFormProvider.notifier).updatePassword(value),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize:
                      20),
              hintStyle: const TextStyle(
                  color: Colors.white),
              errorText: formData.error,
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () =>
                ref.read(loginFormProvider.notifier).submitForm(context),
            child: Text('Iniciar sesión',
                style: TextStyle(color: AppTheme.theme.primaryColor, fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
