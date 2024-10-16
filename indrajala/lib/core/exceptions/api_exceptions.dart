import 'package:indrajala/core/constants/http_statuscode.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, {String? customMessage})
      : message = customMessage ?? HttpStatusCodes.getMessage(statusCode);

  @override
  String toString() {
    return "ApiException: HTTP $statusCode - $message";
  }
}
