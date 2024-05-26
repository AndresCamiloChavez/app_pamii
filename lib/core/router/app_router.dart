import 'package:app_pamii/presentation/pages/auth/login_page.dart';
import 'package:app_pamii/presentation/pages/auth/register_page.dart';
import 'package:app_pamii/presentation/pages/auth/register_page_business.dart';
import 'package:app_pamii/presentation/pages/home/home_page.dart';
import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = ref.read(loginFormProvider).isLoginSuccess;
      final path = state.fullPath;

      print("Log full path ${path}");

      // Permitir explícitamente la navegación a las páginas de registro sin redirección
      if (path!.endsWith('/login/register') ||
          path.endsWith('/login/register-business')) {
        return null;
      }

      if (isLoggedIn && (path == '/login' || path == '/')) {
        // Si el usuario está logueado y está en login o en la ruta raíz, redirigir a home
        return '/home';
      }

      if (!isLoggedIn && path != '/login') {
        // Si el usuario no está logueado y no está en la página de login, redirigir a login
        return '/login';
      }

      // No se necesita redirección para otras condiciones
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
          GoRoute(
            path: 'register-business',
            builder: (context, state) => const RegisterBusinessPage(),
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