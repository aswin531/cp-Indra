class ProfileModel {
  final String name;
  final String email;
  final String subscriptionType;
  final DateTime expiryDate;

  ProfileModel({
    required this.name,
    required this.email,
    required this.subscriptionType,
    required this.expiryDate,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      subscriptionType: json['subscriptionType'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'email': email,

  //   };
  // }
}
