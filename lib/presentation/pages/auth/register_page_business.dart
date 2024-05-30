import 'package:app_pamii/core/constants/colors.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/presentation/pages/auth/widgets/common_widgets_page.dart';
import 'package:app_pamii/presentation/providers/auth/register/register_business_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterBusinessPage extends ConsumerWidget {
  const RegisterBusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = ref
        .watch(registerCompanyFormProvider); // Usando el provider de registro

    return Scaffold(
      body: Stack(
        children: [
          BackGroundImage(),
          FirstTitle(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value) => ref
                          .read(registerCompanyFormProvider.notifier)
                          .updateName(value),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Nombre de negocio',
                          errorText: formData.errors['name'],
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                    TextField(
                      onChanged: (value) => ref
                          .read(registerCompanyFormProvider.notifier)
                          .updateDescription(value),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      minLines: 2,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Descripción',
                          errorText: formData.errors['description'],
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),

                    TextField(
                      onChanged: (value) => ref
                          .read(registerCompanyFormProvider.notifier)
                          .updateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          errorText: formData.errors['email'],
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                    TextField(
                      onChanged: (value) => ref
                          .read(registerCompanyFormProvider.notifier)
                          .updatePassword(value),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        errorText: formData.errors['password'],
                        labelText: 'Contraseña',
                        labelStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
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
                                color: AppTheme.theme.primaryColor,
                                fontSize: 17)),
                      ),
                    ),
                    PageRedirection(
                      message: "¿Ya tienes una cuenta?",
                      option: "Ingresa",
                      onTap: () {
                        ref.read(routerProvider).push('/login');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
