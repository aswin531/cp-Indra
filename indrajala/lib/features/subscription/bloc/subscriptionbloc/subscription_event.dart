import 'package:equatable/equatable.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class ToggleUserType extends SubscriptionEvent {}

class LoadSubscriptionPlans extends SubscriptionEvent {}

class SelectPlan extends SubscriptionEvent {
  final String planId;
  const SelectPlan(this.planId);
}