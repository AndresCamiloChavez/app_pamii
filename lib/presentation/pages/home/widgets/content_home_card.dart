import 'package:app_pamii/domain/entities/company/company.entity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/service.entity.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
      ),
    );
  }
}

class CompanySection extends StatelessWidget {

  final AsyncValue<List<CompanyResponse>> companies;
  const CompanySection(this.companies,{super.key});

  @override
  Widget build(BuildContext context) {
    return companies.when(
      data: (List<CompanyResponse> companies) => CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
        ),
        items: companies
            .map((company) => Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          company.urlFrontPage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          company.name,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final CompanyResponse company;
  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(
              company.urlFrontPage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              company.name,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceSection extends StatelessWidget {
  final AsyncValue<List<Service>> serviceList; // Asegúrate de que esta línea esté correcta

  const ServiceSection(this.serviceList ,{super.key});

  @override
  Widget build(BuildContext context) {
    return serviceList.when(
      data: (List<Service> services) => CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.4,
          // aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
        ),
        items:
            services.map((service) => ServiceCard(service: service)).toList(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundImage: NetworkImage(service.genericPhoto),
              backgroundColor: Colors.transparent,
              radius: 90,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              service.name,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
