import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/constants/http_statuscode.dart';
import 'package:indrajala/core/exceptions/api_exceptions.dart';
import 'package:indrajala/features/auth/data/model/auth_model.dart';

class AuthRemoteDatasource {
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await httpClient.post(
        Uri.parse(ApiConstants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == HttpStatusCodes.ok) {
        debugPrint(responseData.toString());
        debugPrint(response.statusCode.toString());
        return AuthResponse.fromJson(responseData);
      } else {
        throw ApiException(response.statusCode,
            customMessage: responseData['error']);
      }
    } catch (e) {
      throw ApiException(HttpStatusCodes.internalServerError,
          customMessage: 'Login failed: $e');
      //throw Exception('Login failed: $e');
    }
  }

  Future<AuthResponse> signup(
      String name, String email, String password) async {
    try {
      final response = await httpClient.post(
        Uri.parse(ApiConstants.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == HttpStatusCodes.created) {
        return AuthResponse.fromJson(responseData);
      } else {
        throw ApiException(response.statusCode,
            customMessage: responseData['error']);
      }
    } catch (e) {
      throw ApiException(HttpStatusCodes.internalServerError,
          customMessage: 'Registration failed: $e');

      //throw Exception('Registration failed: $e');
    }
  }
}
