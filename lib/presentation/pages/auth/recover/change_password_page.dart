import 'package:app_pamii/presentation/providers/auth/forget/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordPage extends ConsumerWidget {
  final String email;

  const ChangePasswordPage({required this.email, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(changePasswordProvider);

    ref.listen<ChangePasswordState>(changePasswordProvider, (previous, next) {
      if (next.isSuccess) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SuccessScreen()));
      }

      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              obscureText: true,
              onChanged: (value) => ref.read(changePasswordProvider.notifier).updateNewPassword(value),
              decoration: InputDecoration(
                labelText: 'Nueva Contraseña',
                hintText: 'Ingresa tu nueva contraseña',
                errorText: provider.error,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              onChanged: (value) => ref.read(changePasswordProvider.notifier).updateConfirmPassword(value),
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                hintText: 'Reingresa tu nueva contraseña',
                errorText: provider.error,
              ),
            ),
            SizedBox(height: 16),
            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () => ref.read(changePasswordProvider.notifier).changePassword(email),
                    child: Text('Cambiar Contraseña'),
                  ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Éxito'),
      ),
      body: Center(
        child: Text('Contraseña cambiada exitosamente.'),
      ),
    );
  }
}
