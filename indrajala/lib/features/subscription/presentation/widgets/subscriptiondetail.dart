import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/core/widgets/custom_snackbar.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_bloc.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_event.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_state.dart';
import 'package:indrajala/features/subscription/data/model/subscription_order_model.dart';
import 'package:indrajala/features/subscription/data/model/subscriptionplan_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionDetailPage extends StatefulWidget {
  final SubscriptionPlanModel selectedPlan;
  final bool isInternational;

  final String price;

  const SubscriptionDetailPage(
      {super.key,
      required this.selectedPlan,
      required this.price,
      required this.isInternational});

  @override
  // ignore: library_private_types_in_public_api
  _SubscriptionDetailPageState createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  late Razorpay _razorpay;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.read<PaymentBloc>().add(VerifyPaymentEvent(
          isInternational: widget.isInternational,
          orderId: response.orderId!,
          paymentId: response.paymentId!,
          signature: response.signature!,
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showCustomSnackbar(
        context,
        'Payment cancelled',
        //${response.message ?? 'Unknown error'}',
        IAppColors.red);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showCustomSnackbar(context,
        'External wallet selected: ${response.walletName}', IAppColors.red);
  }

  void _openRazorpayCheckout(Order order) {
    var options = {
      'key': ApiConstants.rAZORPAYID,
      'amount': order.amount,
      'name': 'Indrajala',
      'order_id': order.orderId,
      'prefill': {
        'contact': phoneController.text,
        'email': emailController.text,
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    // print('Razorpay Options: $options'); // Debugging the options

    try {
      _razorpay.open(options);
    } catch (e) {
      //  print('Razorpay Error: $e'); // Log the error for debugging
      showCustomSnackbar(context, 'Error: ${e.toString()}', IAppColors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IAppColors.bgBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSelectedPlanCard(),
                  const SizedBox(height: 30),
                  _buildCheckoutForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedPlanCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IAppColors.black,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: IAppColors.pink.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(widget.selectedPlan.title,
                style: IAppTextStyles.headTextPink),
          ),
          const SizedBox(height: 8),
          Text(
            widget.price,
            style: IAppTextStyles.heading1,
          ),
          const SizedBox(height: 16),
          _buildFeatureRow('Full HD streaming'),
          _buildFeatureRow('${widget.selectedPlan.devices} device at a time'),
          _buildFeatureRow('${widget.selectedPlan.days} Days of Validity'),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: IAppColors.pink, size: 20),
          const SizedBox(width: 8),
          Text(feature, style: IAppTextStyles.bodyText),
        ],
      ),
    );
  }

  Widget _buildCheckoutForm() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          // Implement Razorpay payment here using the order details
          _openRazorpayCheckout(state.order); // Call the method here
        } else if (state is PaymentFailure) {
          showCustomSnackbar(context, 'Payment failed: Failed to create order',
              IAppColors.red);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: IAppColors.black,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: IAppColors.pink.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Text('Checkout Form',
                      style: IAppTextStyles.headTextPink)),
              const SizedBox(height: 16),
              Text(
                'Please enter your registered email ID. If you are not registered, please register first.',
                style: IAppTextStyles.localtext,
              ),
              const SizedBox(height: 16),
              _buildTextField('Name:', controller: nameController),
              _buildTextField('Email:', controller: emailController),
              _buildTextField('Phone Number:', controller: phoneController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (state is! PaymentLoading) {
                    context.read<PaymentBloc>().add(CreateOrderEvent(
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          widget.selectedPlan,
                          false,
                        ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: IAppColors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: IAppTextStyles.bodyText,
                ),
                child: state is PaymentLoading
                    ? CircularProgressIndicator(color: IAppColors.white)
                    : Text('Proceed to Payment',
                        style: IAppTextStyles.bodyText),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label,
      {required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: IAppTextStyles.bodyText),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: IAppColors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: IAppColors.pink, width: 2),
            ),
          ),
          style: IAppTextStyles.bodyText,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
