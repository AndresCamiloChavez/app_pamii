import 'dart:convert';

import 'package:app_pamii/core/network/dio_setup.dart';
import 'package:app_pamii/core/network/error_response.dart';
import 'package:app_pamii/domain/entities/company/company.entity.dart';
import 'package:app_pamii/domain/entities/company/company.request.dart';
import 'package:app_pamii/domain/entities/user.request.dart';
import 'package:app_pamii/presentation/providers/auth/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final Dio dio = ref.read(dioProvider);
  return AuthRepository(dio, ref);
});

class AuthRepository {
  final Dio dio;
  final ProviderRef ref;

  AuthRepository(this.dio, this.ref);

  Future<ResponsePamii<T>> _makePostRequest<T>(String path,
      Map<String, dynamic> data, T Function(Map<String, dynamic> json) fromJson,
      [Function(T)? onSuccess]) async {
    try {
      final response = await dio.post(path, data: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          if (response.data != null && response.data is Map<String, dynamic>) {
            T result = fromJson(response.data);
            if (onSuccess != null) onSuccess(result);
            return ResponsePamii<T>(response: result);
          } else {
            throw Exception(
                "Response data is not a valid Map<String, dynamic>");
          }
        } catch (e) {
          return ResponsePamii<T>(
              isFailure: true, messageError: "Error al procesar los datos");
        }
      }
      return ResponsePamii<T>(
          isFailure: true, messageError: "Ocurrió un error en el sistema");
    } on DioException catch (e) {
      return ResponsePamii<T>(
          isFailure: true,
          messageError:
              e.response?.data['message'] ?? "Ocurrió un error en el sistema");
    }
  }

  Future<ResponsePamii<LoginUserResponse>> login(
      String email, String password) {
    return _makePostRequest<LoginUserResponse>(
        '/auth/login',
        {'email': email, 'password': password},
        LoginUserResponse.fromJson,
        (user) => ref.read(authProvider.notifier).login(user.token));
  }

  Future<ResponsePamii<User>> register(UserRequest userRequest) {
    return _makePostRequest<User>(
        '/users/register', userRequest.toJson(), User.fromJson);
  }

  Future<ResponsePamii<CompanyResponse>> registerCompany(
      CompanyRequest companyRequest) {
    return _makePostRequest<CompanyResponse>('/business/register',
        companyRequest.toJson(), CompanyResponse.fromJson);
  }

  Future<ResponsePamii<MessageResponse>> sendCodeRecover(String email) {

     return _makePostRequest<MessageResponse>(
        '/auth/sendCodeRecoverPassword',
        {'email': email},
        MessageResponse.fromJson);
  }

  Future<ResponsePamii<MessageResponse>> verificationCodeRecover(String email, String code) {

     return _makePostRequest<MessageResponse>(
        '/auth//verificationCode',
        {'email': email, 'code': code},
        MessageResponse.fromJson);
  }

  
}
