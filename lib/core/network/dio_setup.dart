import 'package:app_pamii/core/constants/constants.dart';
import 'package:app_pamii/presentation/providers/auth/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = ref.read(authProvider).token;
      if (token != null) {
        options.headers['Authorization'] = token;
      }
      return handler.next(options);
    },
    onError: (DioException e, handler) {
      //! Aquí puedes manejar errores específicos, como token expirado
      return handler.next(e);
    },
  ));

  return dio;
});
