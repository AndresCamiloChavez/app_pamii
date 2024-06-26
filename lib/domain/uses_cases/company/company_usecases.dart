import 'package:app_pamii/data/repositories/company/company_repository.dart';
import 'package:app_pamii/domain/entities/company/company.entity.dart';

class GetCompaniesUseCase {
  final CompanyRepository repository;

  GetCompaniesUseCase(this.repository);

  Future<List<CompanyResponse>> call() async {
    // Añadir lógica de negocio adicional si es necesario
    return await repository.getCompanies();
  }
}