import 'package:app_pamii/core/router/app_router.dart';
import 'package:app_pamii/presentation/pages/auth/widgets/common_widgets_page.dart';
import 'package:app_pamii/presentation/pages/auth/widgets/form_register_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterBusinessPage extends ConsumerWidget {
  const RegisterBusinessPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundImage(),
       
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height 
                ),
                child: IntrinsicHeight(
                  child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FirstTitle(),
                    const RegisterBusinessForm(),
                    PageRedirection(
                      onTap: () {
                        ref.read(routerProvider).push('/login');
                      },
                    )
                  ],
                ),
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
