class SubscriptionPlanModel {
  final String id;
  final String title;
  final double priceInr;
  final double priceUsd;
  final int days;
  final int devices;

  SubscriptionPlanModel({
    required this.id,
    required this.title,
    required this.priceInr,
    required this.priceUsd,
    required this.days,
    required this.devices
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'],
      title: json['title'],
      priceInr: json['price_inr'].toDouble(),
      priceUsd: json['price_usd'].toDouble(),
      days: json['days'],
      devices: json['devices']
    );
  }
}
