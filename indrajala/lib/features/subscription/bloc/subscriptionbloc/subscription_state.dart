import 'package:equatable/equatable.dart';
import 'package:indrajala/features/subscription/data/model/subscriptionplan_model.dart';


class SubscriptionState extends Equatable {
  final List<SubscriptionPlanModel> plans;
  final bool isIndianUser;
  final String? selectedPlanId;

  const SubscriptionState({
    required this.plans,
    required this.isIndianUser,
    this.selectedPlanId,
  });

  SubscriptionState copyWith({
    List<SubscriptionPlanModel>? plans,
    bool? isIndianUser,
    String? selectedPlanId,
  }) {
    return SubscriptionState(
      plans: plans ?? this.plans,
      isIndianUser: isIndianUser ?? this.isIndianUser,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
    );
  }

  @override
  List<Object?> get props => [plans, isIndianUser, selectedPlanId];
}