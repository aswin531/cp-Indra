// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class SubscriptionDetailPage extends StatefulWidget {
//   final SubscriptionPlanModel selectedPlan;
//   final bool isIndianUser;

//   const SubscriptionDetailPage({
//     Key? key,
//     required this.selectedPlan,
//     required this.isIndianUser,
//   }) : super(key: key);

//   @override
//   _SubscriptionDetailPageState createState() => _SubscriptionDetailPageState();
// }

// class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     context.read<PaymentBloc>().add(VerifyPaymentEvent(
//           orderId: response.orderId!,
//           paymentId: response.paymentId!,
//           signature: response.signature!,
//           isInternational: !widget.isIndianUser,
//         ));
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Payment failed: ${response.message}')),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('External wallet selected: ${response.walletName}')),
//     );
//   }

//   void openCheckout(String orderId, int amount) {
//     var options = {
//       'key': 'YOUR_RAZORPAY_KEY',
//       'amount': amount,
//       'name': 'Your App Name',
//       'order_id': orderId,
//       'description': 'Subscription Payment',
//       'prefill': {'contact': '', 'email': ''},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   // ... rest of the build method and other widget methods

//   Widget _buildCheckoutForm() {
//     // ... existing code

//     return BlocConsumer<PaymentBloc, PaymentState>(
//       listener: (context, state) {
//         if (state is PaymentSuccess) {
//           openCheckout(state.order.id, state.order.amount);
//         } else if (state is PaymentFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Payment failed: ${state.error}')),
//           );
//         } else if (state is PaymentVerificationSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Payment successful!')),
//           );
//           // Navigate to success page or update UI accordingly
//         } else if (state is PaymentVerificationFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Payment verification failed')),
//           );
//         }
//       },
//       builder: (context, state) {
//         // ... existing code
//       },
//     );
//   }
// }