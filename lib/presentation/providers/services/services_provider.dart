import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/data/repositories/services/services_repository.dart';
import 'package:app_pamii/domain/entities/service.entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  final dio = ref.read(dioProvider); // Asegúrate de tener un provider para Dio
  return ServiceRepository(dio, ref);
});

final serviceListProvider = FutureProvider<List<Service>>((ref) async {
  return ref.read(serviceRepositoryProvider).getServices();
});