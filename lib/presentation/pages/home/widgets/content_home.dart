import 'package:app_pamii/presentation/pages/home/widgets/content_home_card.dart';
import 'package:app_pamii/presentation/providers/company/company_provider.dart';
import 'package:app_pamii/presentation/providers/services/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentHome extends ConsumerWidget {
  const ContentHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.refresh(companyListProvider.future),
          ref.refresh(serviceListProvider.future),
        ]);
      },
      child: ListView(
        children: [
          const SectionTitle(title: "Principales Servicios"),
          ServiceSection(ref.watch(serviceListProvider)),
          const SectionTitle(title: "Principales Negocios"),
          CompanySection(ref.watch(companyListProvider)),
          const SectionTitle(title: "Negocios cerca a ti"),
          CompanySection(ref.watch(companyListProvider)),
        ],
      ),
    );
  }
}
