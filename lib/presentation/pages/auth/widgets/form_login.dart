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
            onChanged: (value) => ref.read(loginFormProvider.notifier).updateEmail(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              errorText: formData.error,
            ),
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            onChanged: (value) => ref.read(loginFormProvider.notifier).updatePassword(value),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintStyle: const TextStyle(color: Colors.white),
              errorText: formData.error,
              hoverColor: Colors.white
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => ref.read(loginFormProvider.notifier).submitForm(),
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}