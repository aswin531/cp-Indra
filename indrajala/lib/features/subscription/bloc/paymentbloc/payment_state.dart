import 'package:indrajala/features/subscription/data/model/subscription_order_model.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final Order order;

  PaymentSuccess(this.order);
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message);
}

class PaymentVerificationSuccess extends PaymentState {}

class PaymentVerificationFailure extends PaymentState {}
