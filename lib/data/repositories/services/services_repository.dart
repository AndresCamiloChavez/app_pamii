

import 'package:app_pamii/domain/entities/service.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceRepository {
  final Dio dio;
  final ProviderRef ref;

  ServiceRepository(this.dio, this.ref);

  Future<List<Service>> getServices() async {
    try {
      final response = await dio.get('/service');
      if (response.statusCode == 200) {
        List<Service> services = (response.data as List).map((ServiceJson) => ServiceModel.fromJson(ServiceJson)).toList();
        print("Obitene servicios ${services}");
        return services;
        
      }
      return [];
    } catch (e) {
      // Manejo de error, podrías implementar una mejor gestión de errores según el caso.
      return [];
    }
  }
}