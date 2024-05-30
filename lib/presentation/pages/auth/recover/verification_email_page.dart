import 'package:app_pamii/core/constants/colors.dart';
import 'package:flutter/material.dart';

class VerificationEmailPage extends StatelessWidget {
  const VerificationEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 142, 144,
                            146),
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
                  onPressed: () {},
                  child: const Text('Iniciar sesión',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
