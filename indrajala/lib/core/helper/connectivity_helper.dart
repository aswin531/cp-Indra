import 'dart:io';

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

//web
// Future<bool> checkInternetConnection() async {
//   try {
//     final response = await http.get(Uri.parse('https://www.google.com')).timeout(Duration(seconds: 5));
//     return response.statusCode == 200;
//   } catch (_) {
//     return false; // No internet connection
//   }
// }