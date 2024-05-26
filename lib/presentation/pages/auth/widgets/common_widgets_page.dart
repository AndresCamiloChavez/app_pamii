import 'package:app_pamii/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageRedirection extends ConsumerWidget {
  final String message;
  final String option;
  final VoidCallback onTap;

  const PageRedirection(
      {
      super.key,
      required this.onTap,
      this.message = "¿No tienes cuenta aún?",
      this.option = "Resgistrate"
      }
  );

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
              onPressed: onTap,
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
