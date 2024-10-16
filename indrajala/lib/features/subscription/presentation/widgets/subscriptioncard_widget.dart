import 'package:flutter/material.dart';
import 'package:indrajala/core/responsive/responsive_config.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/features/subscription/data/model/subscriptionplan_model.dart';
import 'package:indrajala/features/subscription/presentation/widgets/subscriptiondetail.dart';
import 'package:indrajala/features/subscription/presentation/widgets/subscriptionfeauture_widget.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final int days;
  final String planId;
  final bool isSelected;
  final int devices;
  final VoidCallback onSelect;
  final SubscriptionPlanModel subscriptionPlanModel;
  final bool indianUser;

  const SubscriptionCard(
      {super.key,
      required this.title,
      required this.price,
      required this.days,
      required this.planId,
      required this.isSelected,
      required this.onSelect,
      required this.devices,
      required this.subscriptionPlanModel,
      required this.indianUser});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveSize.getCardWidth(context),
      child: GestureDetector(
        onTap: onSelect,
        child: Card(
          color: isSelected ? Colors.pink.withOpacity(0.2) : Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: isSelected ? Colors.pink : Colors.transparent,
              width: 2,
            ),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: IAppTextStyles.bodyText.copyWith(color: Colors.pink),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  price,
                  style: IAppTextStyles.heading1.copyWith(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const SubscriptionFeature(text: 'Full HD streaming'),
                SubscriptionFeature(text: '$devices  device at a time'),
                SubscriptionFeature(text: '$days Days of Validity'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (isSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionDetailPage(
                            price: price,
                            isInternational: indianUser,
                            selectedPlan: subscriptionPlanModel,
                          ),
                        ),
                      );
                    } else {
                      onSelect();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isSelected ? 'View Details' : 'Select Plan',
                    style: IAppTextStyles.localtext.copyWith(
                      color: IAppColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
