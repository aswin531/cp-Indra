import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_event.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_state.dart';
import 'package:indrajala/features/subscription/domain/repository/subscription_plan_repository.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;

  SubscriptionBloc(this.subscriptionRepository)
      : super(const SubscriptionState(plans: [], isIndianUser: true, selectedPlanId: null)) {
    on<LoadSubscriptionPlans>(_onLoadSubscriptionPlans);
    on<ToggleUserType>(_onToggleUserType);
    on<SelectPlan>(_onSelectPlan);
  }

  Future<void> _onLoadSubscriptionPlans(
      LoadSubscriptionPlans event, Emitter<SubscriptionState> emit) async {
    try {
      final plans = await subscriptionRepository.getSubscriptionPlans();
      emit(state.copyWith(plans: plans));
    } catch (e) {
      // Handle error, maybe emit an error state
      // print('Error loading subscription plans: $e');
    }
  }

  void _onToggleUserType(ToggleUserType event, Emitter<SubscriptionState> emit) {
    emit(state.copyWith(isIndianUser: !state.isIndianUser));
  }

  Future<void> _onSelectPlan(SelectPlan event, Emitter<SubscriptionState> emit) async {
    await subscriptionRepository.selectPlan(event.planId);
    emit(state.copyWith(selectedPlanId: event.planId));
  }
}