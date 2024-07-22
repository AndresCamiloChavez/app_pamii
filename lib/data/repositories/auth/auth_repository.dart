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

  Future<ResponsePamii<dynamic>> login(String email, String password) {
    return _makePostRequest<dynamic>(
      '/auth/login',
      {'email': email, 'password': password},
      parseResponse,
      (response) {
        if (response is UserResponse) {
          ref.read(authProvider.notifier).login(response.token);
        }
        // Manejar otros tipos de respuesta aquí si es necesario
      },
    );
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
    return _makePostRequest<MessageResponse>('/auth/sendCodeRecoverPassword',
        {'email': email}, MessageResponse.fromJson);
  }

  Future<ResponsePamii<MessageResponse>> verificationCodeRecover(
      String email, String code) {
    return _makePostRequest<MessageResponse>('/auth/verificationCode',
        {'email': email, 'code': code}, MessageResponse.fromJson);
  }

  dynamic parseResponse(Map<String, dynamic> json) {
    if (json.containsKey('business')) {
      return BusinessResponse.fromJson(json);
    } else if (json.containsKey('user')) {
      return UserResponse.fromJson(json);
    } else {
      throw Exception("No se puede determinar el tipo de respuesta");
    }
  }
}

// Definición de modelos de respuesta

class ResponsePamii<T> {
  final T? response;
  final bool isFailure;
  final String? messageError;

  ResponsePamii({this.response, this.isFailure = false, this.messageError});
}

class UserResponse {
  final User user;
  final String token;

  UserResponse({required this.user, required this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class BusinessResponse {
  final Business business;
  final String token;

  BusinessResponse({required this.business, required this.token});

  factory BusinessResponse.fromJson(Map<String, dynamic> json) {
    return BusinessResponse(
      business: Business.fromJson(json['business']),
      token: json['token'],
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String birthDay;
  final bool isActive;
  final String? resetCode;
  final String? resetCodeTimestamp;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.birthDay,
    required this.isActive,
    this.resetCode,
    this.resetCodeTimestamp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      email: json['email'],
      birthDay: json['birthDay'],
      isActive: json['isActive'],
      resetCode: json['resetCode'],
      resetCodeTimestamp: json['resetCodeTimestamp'],
    );
  }
}

class Business {
  final int id;
  final String name;
  final String description;
  final String? urlLogo;
  final String? urlFrontPage;
  final String? address;
  final bool isActive;
  final String email;

  Business({
    required this.id,
    required this.name,
    required this.description,
    this.urlLogo,
    this.urlFrontPage,
    this.address,
    required this.isActive,
    required this.email,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      urlLogo: json['urlLogo'],
      urlFrontPage: json['urlFrontPage'],
      address: json['address'],
      isActive: json['isActive'],
      email: json['email'],
    );
  }
}

class MessageResponse {
  final String message;

  MessageResponse({required this.message});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      message: json['message'],
    );
  }
}
