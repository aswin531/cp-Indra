
class Order {
  final String orderId;
  final int amount;
  final String currency;
  final String receipt;
  final String message;

  Order(
    {
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
    required this.message,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      message:json['message'],
      orderId: json['orderId'],
      amount: json['amount'],
      currency: json['currency'],
      receipt: json['receipt'],
    );
  }
}
