import 'package:indrajala/features/subscription/domain/repository/payment_repository.dart';

class VerifyPaymentUseCase {
  final PaymentRepository repository;

  VerifyPaymentUseCase(this.repository);

  Future<bool> call(String orderId, String paymentId, String signature,
      bool isInternational) {
    return repository.verifyPayment(
        orderId, paymentId, signature, isInternational);
  }
}

