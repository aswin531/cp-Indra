import 'package:indrajala/features/subscription/data/datasource/payment_datasource.dart';
import 'package:indrajala/features/subscription/data/model/subscription_order_model.dart';
import 'package:indrajala/features/subscription/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Order> createOrder({
    required String name,
    required String email,
    required String phone,
    required String planId, 
   // required double amount,
    required bool isInternational,
  }) async {
    return await remoteDataSource.createOrder(
      name,
      email,
      phone,
      int.parse(planId), 
      isInternational,
    );
  }


  @override
  Future<bool> verifyPayment(String orderId, String paymentId, String signature, bool isInternational) async {
    return await remoteDataSource.verifyPayment(orderId, paymentId, signature, isInternational);
  }
}