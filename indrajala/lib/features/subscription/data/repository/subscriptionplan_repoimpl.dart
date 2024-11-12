import 'package:indrajala/features/subscription/data/model/subscriptionplan_model.dart';
import 'package:indrajala/features/subscription/domain/repository/subscription_plan_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  @override
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans() async {
    return [
      SubscriptionPlanModel(
          id: '1',
          title: 'Basic',
          priceInr: 299,
          priceUsd: 3.75,
          days: 15,
          devices: 1),
      SubscriptionPlanModel(
          id: '2',
          title: 'Gold',
          priceInr: 399,
          priceUsd: 5,
          days: 30,
          devices: 1),
      SubscriptionPlanModel(
          id: '3',
          title: 'Standard',
          priceInr: 599,
          priceUsd: 7.5,
          days: 60,
          devices: 2),
      SubscriptionPlanModel(
          id: '4',
          title: 'Premium',
          priceInr: 999,
          priceUsd: 11.75,
          days: 90,
          devices: 3),
    ];
  }

  @override
  Future<void> selectPlan(String planId) async {
   // debugPrint('Plan selected: $planId');
  }
}
