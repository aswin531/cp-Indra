import 'dart:convert';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/constants/http_statuscode.dart';
import 'package:indrajala/features/subscription/data/model/subscription_order_model.dart';

class PaymentRemoteDataSource {
  Future<Order> createOrder(String name, String email, String phone, int option,
      bool isInternational) async {
    final url = isInternational
        ? ApiConstants.nonNationalUser
        : ApiConstants.nationalUser;

    final response = await httpClient.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Name": name,
        "Email": email,
        "PhoneNumber": phone,
        "Option": option,
      }),
    );

    if (response.statusCode == HttpStatusCodes.ok) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<bool> verifyPayment(String orderId, String paymentId, String signature,
      bool isInternational) async {
    final url =
        isInternational ? ApiConstants.verifyPayment : ApiConstants.checkStatus;

    final response = await httpClient.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "razorpay_order_id": orderId,
        "razorpay_payment_id": paymentId,
        "razorpay_signature": signature,
      }),
    );

    final result = jsonDecode(response.body);
    //debugPrint(result.toString());
    if (result['success']) {
      return true;
    } else {
      return false;
    }
  }
}
