import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/data/repositories/company/company_repository.dart';
import 'package:app_pamii/domain/entities/company/company.entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  final dio = ref.read(dioProvider); // Asegúrate de tener un provider para Dio
  return CompanyRepository(dio, ref);
});

final companyListProvider = FutureProvider<List<CompanyResponse>>((ref) async {
  return ref.read(companyRepositoryProvider).getCompanies();
});