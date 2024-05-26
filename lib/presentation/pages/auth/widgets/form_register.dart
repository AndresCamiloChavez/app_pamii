import 'package:app_pamii/presentation/providers/auth/register/register_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData =
        ref.watch(registerFormProvider); // Usando el provider de registro
    TextEditingController dateInputController =
        TextEditingController(text: formData.birthDay);

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
                    ref.read(registerFormProvider.notifier).updateName(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Nombre',
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) => ref
                    .read(registerFormProvider.notifier)
                    .updateLastName(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Apellido',  
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            )
          ]),
          Row(children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) =>
                    ref.read(registerFormProvider.notifier).updatePhone(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Teléfono',
                    errorText: formData.error,
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: dateInputController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  labelText: 'Fecha de nacimiento',
                  labelStyle: const TextStyle(color: Colors.white),
                  errorText: formData.error,
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white,
                            surface: Colors.blueGrey,
                            onSurface: Colors.yellow,
                          ),
                          dialogBackgroundColor: Colors.blue[500],
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    dateInputController.text =
                        formattedDate; // Actualizar el texto del TextField
                    ref
                        .read(registerFormProvider.notifier)
                        .updateBirthDay(formattedDate); // Actualizar el estado
                  }
                },
              ),
            )
          ]),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).updateEmail(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Correo electrónico',
                errorText: formData.error,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).updatePassword(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
              hintStyle: const TextStyle(color: Colors.white),
              errorText: formData.error,
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                ref.read(registerFormProvider.notifier).submitForm(context),
            child: const Text('Registrar', style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }
}