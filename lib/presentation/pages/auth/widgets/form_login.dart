import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(loginFormProvider);

    return Column(
      children: [
        TextField(
          onChanged: (value) => ref.read(loginFormProvider.notifier).updateEmail(value),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: formData.error,
          ),
        ),
        TextField(
          onChanged: (value) => ref.read(loginFormProvider.notifier).updatePassword(value),
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: formData.error,
          ),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () => ref.read(loginFormProvider.notifier).submitForm(),
          child: const Text('Login'),
        ),
      ],
    );
  }
}