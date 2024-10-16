// import 'package:flutter/material.dart';

// Future<bool> checkUserSubscription() async {
//   try {
//     // Retrieve the token from local storage
//     String? token = await getToken();

//     // If token is null, the user is not authenticated or the token is missing
//     if (token ) {
//       debugPrint('User is not authenticated or token is missing.');
//       return false; // User is not subscribed
//     }

//     // Check the subscription status using the token
//     return await checkSubscriptionStatus(token);
//   } catch (e) {
//     // Handle exceptions such as network errors
//     debugPrint('Error checking subscription status: $e');
//     return false; // Consider user as not subscribed in case of error
//   }
// }
