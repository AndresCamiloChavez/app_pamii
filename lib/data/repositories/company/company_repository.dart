

import 'package:app_pamii/domain/entities/company/company.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyRepository {
  final Dio dio;
  final ProviderRef ref;

  CompanyRepository(this.dio, this.ref);

  Future<List<CompanyResponse>> getCompanies() async {
    try {
      final response = await dio.get('/business');
      if (response.statusCode == 200) {
        List<CompanyResponse> companies = (response.data as List).map((companyJson) => CompanyResponse.fromJson(companyJson)).toList();
        return companies;
      }
      return [];
    } catch (e) {
      // Manejo de error, podrías implementar una mejor gestión de errores según el caso.
      return [];
    }
  }
}