import 'package:app_pamii/presentation/pages/auth/widgets/form_register.dart';
import 'package:app_pamii/presentation/providers/auth/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/common_widgets_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(loginFormProvider);
    return Scaffold(
        body: Stack(children: [
      const BackGroundImage(),
      if (formData.isLoading) const Center(child: CircularProgressIndicator()),
      SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (formData.isLoading) const CircularProgressIndicator(),
            const FirstTitle(),
            const RegisterForm(),
            const PageRedirection(
              message: "¿Ya tienes una cuenta?",
              option: "Ingresa",
            )
          ],
        ),
      ))
    ]));
  }
}
