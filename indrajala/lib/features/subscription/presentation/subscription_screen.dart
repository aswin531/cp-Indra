import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_bloc.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_event.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_state.dart';
import 'package:indrajala/features/subscription/data/repository/subscriptionplan_repoimpl.dart';
import 'package:indrajala/features/subscription/presentation/widgets/subscriptioncard_widget.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionBloc(
        SubscriptionRepositoryImpl(),
      )..add(LoadSubscriptionPlans()),
      child: Scaffold(
        backgroundColor: IAppColors.bgBlack,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'The OTT of Your ',
                    style: IAppTextStyles.headTextPink,
                  ),
                  Text(
                    'Fantasies ',
                    style: IAppTextStyles.headTextPink,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<SubscriptionBloc, SubscriptionState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: state.isIndianUser,
                                onChanged: (_) {
                                  context
                                      .read<SubscriptionBloc>()
                                      .add(ToggleUserType());
                                },
                                activeColor: IAppColors.pink,
                                inactiveThumbColor: IAppColors.pink,
                                inactiveTrackColor:
                                    Colors.black.withOpacity(0.3),
                                activeTrackColor: Colors.pink.withOpacity(0.3),
                                trackOutlineColor:
                                    WidgetStateProperty.all(IAppColors.pink),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                state.isIndianUser
                                    ? 'Indian User'
                                    : 'Non-Indian User',
                                style: TextStyle(
                                  color: IAppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (state.plans.isEmpty)
                            const CircularProgressIndicator(
                                color: Color.fromRGBO(255, 45, 114, 1))
                                
                          else
                            ...state.plans.map((plan) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SubscriptionCard(subscriptionPlanModel: plan,
                                  indianUser: state.isIndianUser,
                                    devices: plan.devices,
                                    title: plan.title,
                                    price: state.isIndianUser
                                        ? '₹${plan.priceInr}'
                                        : '\$${plan.priceUsd}',
                                    days: plan.days,
                                    planId: plan.id,
                                    isSelected: state.selectedPlanId == plan.id,
                                    onSelect: () {
                                      context
                                          .read<SubscriptionBloc>()
                                          .add(SelectPlan(plan.id));
                                    },
                                  ),
                                ))
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
