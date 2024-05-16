import 'package:app_pamii/presentation/providers/company/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentHome extends ConsumerWidget {
  const ContentHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyList = ref.watch(companyListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Principales Negocios",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
        SizedBox(
            height: 200,
            child: companyList.when(
              data: (companies) => PageView.builder(
                  pageSnapping: true,
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    final company = companies[index];
                    return Card(
                      color: Colors.blue,
                      child: Center(
                        child: Text(company.name),
                      ),
                    );
                  }),
              error: (error, stackTrace) {},
              loading: () {
              },
            )),
      ],
    );
  }
}
