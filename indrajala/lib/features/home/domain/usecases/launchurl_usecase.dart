import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUseCase {
  Future<void> call(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $urlString';
  }
}
}
