import 'package:app_pamii/core/constants/colors.dart';
import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:app_pamii/presentation/providers/auth/register/register_business_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterBusinessForm extends ConsumerWidget {
  const RegisterBusinessForm({super.key});

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
            onChanged: (value) => ref
                .read(registerCompanyFormProvider.notifier)
                .updateName(value),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Nombre de negocio',
                errorText: formData.error,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextField(
            onChanged: (value) => ref
                .read(registerCompanyFormProvider.notifier)
                .updateDescription(value),
            keyboardType: TextInputType.multiline,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Descripción',
                errorText: formData.error,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextField(
            onChanged: (value) => ref
                .read(registerCompanyFormProvider.notifier)
                .updateEmail(value),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Correo electrónico',
                errorText: formData.error,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextField(
            onChanged: (value) => ref
                .read(registerCompanyFormProvider.notifier)
                .updatePassword(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorText: formData.error,
              labelText: 'Contraseña',
              labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
              hintStyle: const TextStyle(color: Colors.white),
            ),
            obscureText: true,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: ElevatedButton(
              onPressed: () => ref
                  .read(registerCompanyFormProvider.notifier)
                  .submitForm(context),
              child: Text('Registrarme',
                  style: TextStyle(
                      color: AppTheme.theme.primaryColor, fontSize: 17)),
            ),
          ),
        ],
      ),
    );
  }
}
