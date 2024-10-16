import 'package:indrajala/features/subscription/data/model/subscription_order_model.dart';

abstract class PaymentRepository {
   Future<Order> createOrder({
    required String name,
    required String email,
    required String phone,
    required String planId,  // Expecting a String for planId
    // required double amount,
    required bool isInternational,
  });
  Future<bool> verifyPayment(
      String orderId, String paymentId, String signature, 
      bool isInternational);
}
