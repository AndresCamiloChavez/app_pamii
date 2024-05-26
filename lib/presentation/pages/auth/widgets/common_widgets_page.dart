import 'package:app_pamii/core/constants/colors.dart';
import 'package:app_pamii/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageRedirection extends ConsumerWidget {
  final String message;
  final String option;

  const PageRedirection(
      {super.key,
      this.message = "¿No tienes cuenta aún?",
      this.option = "Resgistrate"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message,
              style: const TextStyle(color: Colors.white, fontSize: 17)),
          TextButton(
              onPressed: () => ref.read(routerProvider).push('/login/register'),
              child: Text(option,
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
