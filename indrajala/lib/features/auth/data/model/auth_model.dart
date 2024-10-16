class AuthResponse {
  final String token;
  final DateTime? expiryDate;

  AuthResponse({
    required this.token,
    this.expiryDate,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
    );
  }
}
