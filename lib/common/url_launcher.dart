import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

Future<void> sendAnEmail(String subject, String body) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: 'consignt@gmail.com',
    queryParameters: {'subject': subject, 'body': body},
  );

  final String _emailUriString = launchUri
      .toString()
      .replaceAll('+', '\%20');

  await launch(_emailUriString);
}

Future<void> launchInBrowser(String url) async {
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}
