import 'package:app_pamii/presentation/pages/home/widgets/appbar_custom.dart';
import 'package:app_pamii/presentation/pages/home/widgets/content_home.dart';
import 'package:app_pamii/presentation/pages/home/widgets/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider<String>((ref) => '');

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(),
      drawer: DrawerCustom(),
      body: ContentHome(),
    );
  }
}
