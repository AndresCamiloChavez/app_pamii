import 'package:app_pamii/presentation/pages/auth/widgets/common_widgets_page.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/presentation/pages/auth/widgets/form_login.dart';
import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ' Bienvenido ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ' ¡Es un gusto verte! ',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                const Expanded(child: LoginForm()),
                PageRedirection(
                  onTap: () {
                    ref.read(routerProvider).push('/login/register');
                  },
                ),
                PageRedirection(
                  onTap: () {
                    ref.read(routerProvider).push('/login/register-business');
                  },
                  message: "¿No tienes una cuenta Negocio?",
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
