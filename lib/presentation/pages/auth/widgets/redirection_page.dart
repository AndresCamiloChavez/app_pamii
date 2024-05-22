import 'package:app_pamii/core/constants/colors.dart';
import 'package:flutter/material.dart';

class PageRedirection extends StatelessWidget {
  final String message;
  final String option;

  const PageRedirection(
      {super.key,
      this.message = "¿No tienes cuenta aún?",
      this.option = "Resgistrate"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message, style: TextStyle(color: Colors.white, fontSize: 17)),
          TextButton(
              onPressed: () {},
              child: Text(option,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
