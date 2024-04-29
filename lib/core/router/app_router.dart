import 'package:app_pamii/presentation/pages/auth/login_page.dart';
import 'package:app_pamii/presentation/pages/auth/register_page.dart';
import 'package:app_pamii/presentation/pages/home/home_page.dart';
import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      // Aquí, obtenemos el estado del proveedor de autenticación
      final isLoggedIn = ref.read(loginFormProvider).isLoginSuccess;

      print("HLOG navegación  ${isLoggedIn}");

      // Comprobando si estamos en la página de login y el usuario ya está autenticado
      if (state.path == '/login' && isLoggedIn) {
        return '/home';
      }

      // Comprobando si el usuario no está autenticado y no está en la página de login
      if (!isLoggedIn && state.path != '/login') {
        // Redirigir al usuario a la página de login si no está autenticado
        return '/login';
      }

      // No se necesita redirección
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
});
