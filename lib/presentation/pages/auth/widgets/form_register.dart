import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(loginFormProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) =>
                    ref.read(loginFormProvider.notifier).updateEmail(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Nombre',
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) =>
                    ref.read(loginFormProvider.notifier).updateEmail(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Apellido',
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white , fontSize: 20)),
              ),
            )
          ]),
          Row(children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) =>
                    ref.read(loginFormProvider.notifier).updateEmail(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Telefono',
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.datetime,
                onChanged: (value) =>
                    ref.read(loginFormProvider.notifier).updateEmail(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Cumple Años',
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white , fontSize: 20)),
              ),
            )
          ]),
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
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(
                color: Colors.white), // Estilo para el texto ingresado
            onChanged: (value) =>
                ref.read(loginFormProvider.notifier).updatePassword(value),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize:
                      18), // Asegúrate de que el color del label también sea blanco
              hintStyle: const TextStyle(
                  color: Colors.white), // Estilo para el texto de sugerencia
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
                style: TextStyle(color: Colors.amber[900], fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
