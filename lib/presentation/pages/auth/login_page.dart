import 'package:app_pamii/core/constants/colors.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/presentation/pages/auth/widgets/common_widgets_page.dart';
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

        const BackGroundImage(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (formData.isLoading) const CircularProgressIndicator(),
                const FirstTitle(),
                const Expanded(child: LoginForm()),
                Column(
                  children: [
                    const Text("¿Aun no estas resgistrado?",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    const Text("Te identificas como:",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: Card(
                          color: Colors.black,
                          shadowColor: Colors.white,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref.read(routerProvider).push('/login/register');
                                },
                                icon: const Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                  size: 40,
                                )),
                                const Text(
                                "Como usuario",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          color: Colors.black,
                          shadowColor: Colors.white,
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(routerProvider)
                                        .push('/login/register-business');
                                  },
                                  icon: const Icon(
                                    Icons.add_business,
                                    color: AppColors.primaryColor,
                                    size: 40,
                                  )),
                              const Text(
                                "Como negocio",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ])
                  ],
            ),
          ),
        )
      ],
    ));
  }
}
