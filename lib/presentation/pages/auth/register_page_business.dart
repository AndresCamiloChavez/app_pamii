import 'package:app_pamii/presentation/pages/auth/widgets/common_widgets_page.dart';
import 'package:flutter/material.dart';

class RegisterBusinessPage extends StatelessWidget {
  const RegisterBusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BackGroundImage(),
          FirstTitle(),
        ],
      ),
    );
  }
}