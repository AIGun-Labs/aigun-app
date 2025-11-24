import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncherService {
  static Future<void> to(String url) async {
    if (!await url_launcher.launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
