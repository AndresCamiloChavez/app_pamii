import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/presentation/pages/auth/widgets/form_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/common_widgets_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(children: [
      const BackGroundImage(),
      SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(          
          child: ConstrainedBox(constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
          ),
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FirstTitle(),
                const RegisterForm(),
                PageRedirection(
                  onTap: () {
                    ref.read(routerProvider).push('/login');
                  },
                )
              ],
            ),
          ), 
        ),
      ))
    ]));
  }
}
