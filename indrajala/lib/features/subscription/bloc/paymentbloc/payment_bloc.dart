import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_event.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_state.dart';
import 'package:indrajala/features/subscription/domain/usecases/createorder_usecase.dart';
import 'package:indrajala/features/subscription/domain/usecases/verifypayment_usecase.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreateOrderUseCase createOrderUseCase;
  final VerifyPaymentUseCase verifyPaymentUseCase;

  PaymentBloc({
    required this.createOrderUseCase,
    required this.verifyPaymentUseCase,
  }) : super(PaymentInitial()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<VerifyPaymentEvent>(_onVerifyPayment);
  }

  Future<void> _onCreateOrder(
    CreateOrderEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final order = await createOrderUseCase(
          email: event.email,
          name: event.name,
          phone: event.phone,
          isInternational: event.isInternational,
          planId: event.plan.id);
      emit(PaymentSuccess(order));
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  Future<void> _onVerifyPayment(
    VerifyPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final isVerified = await verifyPaymentUseCase(event.orderId,
          event.paymentId, event.signature, event.isInternational);
      if (isVerified) {
        emit(PaymentVerificationSuccess());
      } else {
        emit(PaymentVerificationFailure());
      }
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
