import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_page.dart';

class AppBarCustom extends StatelessWidget implements PreferredSize {
  const AppBarCustom({
    super.key,
  });

   @override
  Size get preferredSize => const Size.fromHeight(56.0);  // Altura estándar de AppBar


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20)), // Radio del borde redondeado
      child: Consumer(
        builder: (context,ref, child) {
          return AppBar(
            backgroundColor: Colors.orange,
            title: TextField(
              onChanged: (text) =>
                  ref.read(searchProvider.notifier).state = text,
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final searchText = ref.read(searchProvider);
                  print('Buscar: $searchText');
                },
              ),
            ],
          );
        }
      ),
    );
  }
  
  @override
  Widget get child => throw UnimplementedError();
}

