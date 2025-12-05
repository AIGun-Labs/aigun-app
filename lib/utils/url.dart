import 'package:url_launcher/url_launcher.dart' as url_launcher;

Future<void> launchUrl(String url) async {
  if (!await url_launcher.launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
