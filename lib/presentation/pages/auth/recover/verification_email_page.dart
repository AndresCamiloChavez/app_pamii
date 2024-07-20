import 'package:app_pamii/core/constants/colors.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/presentation/helpers/loading.dart';
import 'package:app_pamii/presentation/providers/auth/forget/forget_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationEmailPage extends ConsumerWidget {
  const VerificationEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(forgetFormProvider);

    ref.listen<ForgetFormState>(forgetFormProvider, (previous, next) {
      if (next.isLoading && !previous!.isLoading) {
        _showLoadingDialog(context);
      }

      if (!next.isLoading && previous!.isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      if (next.isSuccess && !previous!.isSuccess) {
        _showSecurityCodeDialog(context, ref);
      }

      if (next.isCodeVerified && !previous!.isCodeVerified) {
        ref.read(routerProvider).push('/login/register');
      }
      if (next.isVerificationError && !previous!.isVerificationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error ?? 'Error de verificación'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Recuperación de cuenta',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verificación de cuenta',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Por favor, ingresa tu dirección de correo electrónico para recibir un código de recuperación. Este código te permitirá restablecer tu contraseña y acceder nuevamente a tu cuenta.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) =>
                      ref.read(forgetFormProvider.notifier).updateEmail(value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 142, 144, 146),
                      ),
                    ),
                    hintText: 'Correo electrónico',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14.0),
                  ),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  minWidth: double.infinity,
                  shape: const StadiumBorder(),
                  color: AppTheme.theme.primaryColorDark,
                  onPressed: () {
                    ref.read(forgetFormProvider.notifier).sendCodeRecovery();
                  },
                  child: const Text('Enviar Código',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog(message: "Enviando código...");
      },
    );
  }

  Future<void> _showSecurityCodeDialog(
      BuildContext context, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingresar código de seguridad'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                    'Por favor, ingresa el código de 5 dígitos enviado a tu correo electrónico.'),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => ref
                      .read(forgetFormProvider.notifier)
                      .updateSecurityCode(value),
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Código de seguridad',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(forgetFormProvider.notifier).resetSuccess();
                ref
                    .read(forgetFormProvider.notifier)
                    .verificationCodeRecovery();
              },
            ),
          ],
        );
      },
    );
  }
}
