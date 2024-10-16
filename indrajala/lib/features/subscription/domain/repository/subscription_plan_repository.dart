import 'package:indrajala/features/subscription/data/model/subscriptionplan_model.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans();
  Future<void> selectPlan(String planId);
}