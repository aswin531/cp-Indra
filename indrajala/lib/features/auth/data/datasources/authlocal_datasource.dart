import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDatasource {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
   // debugPrint('From Local Storage TOken: $token');
    await secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> storeExpiryDate(DateTime expiryDate) async {
    await secureStorage.write(
        key: 'token_expiry', value: expiryDate.toIso8601String());
  }

  Future<String?> getToken() async {
    debugPrint('From Local Storage TOken');
    return await secureStorage.read(key: 'auth_token');
  }

  Future<bool> isTokenExpired() async {
    final expiryDateString = await secureStorage.read(key: 'token_expiry');
    if (expiryDateString == null) return false;

    final expiryDate = DateTime.parse(expiryDateString);
    return DateTime.now().isAfter(expiryDate);
  }

  Future<void> clearToken() async {
    await secureStorage.delete(key: 'auth_token');
    await secureStorage.delete(key: 'token_expiry');
  }
}
