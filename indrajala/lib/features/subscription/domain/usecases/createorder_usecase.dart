import 'package:indrajala/features/subscription/data/model/subscription_order_model.dart';
import 'package:indrajala/features/subscription/domain/repository/payment_repository.dart';

class CreateOrderUseCase {
  final PaymentRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Order> call({
    required String name,
    required String email,
    required String phone,
    required String planId,  
    required bool isInternational,
  }) {
    return repository.createOrder(
      name: name,
      email: email,
      phone: phone,
      planId: planId, 
      isInternational: isInternational,
    );
  }
}
