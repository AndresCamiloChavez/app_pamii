
import 'package:app_pamii/data/repositories/services/services_repository.dart';
import 'package:app_pamii/domain/entities/service.entity.dart';

class GetServicesUseCase {
  final ServiceRepository repository;

  GetServicesUseCase(this.repository);

  Future<List<Service>> call() async {
    return await repository.getServices();
  }
}