import 'package:indrajala/features/subscription/data/model/subscriptionplan_model.dart';

abstract class PaymentEvent {}

class CreateOrderEvent extends PaymentEvent {
  final String name;
  final String email;
  final String phone;
  final SubscriptionPlanModel plan;
  final bool isInternational;

  CreateOrderEvent(
      this.name, this.email, this.phone, this.plan, this.isInternational);
}

class VerifyPaymentEvent extends PaymentEvent {
  final String orderId;
  final String paymentId;
  final String signature;
  final bool isInternational;

  VerifyPaymentEvent(
      {required this.orderId,
      required this.paymentId,
      required this.signature,
      required this.isInternational
      });
}
