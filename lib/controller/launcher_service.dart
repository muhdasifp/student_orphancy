import 'package:care_life/utility/toast_message.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  ///to launch google map using latitude and longitude
  Future<void> launchGoogleMap(String lat, String long) async {
    final String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";

    if (!await launchUrl(Uri.parse(googleMapUrl))) {
      throw Exception("Url is not launched");
    }
  }

  /// to send email for the particular user
  Future<void> launchEmail(String mailAddress) async {
    String email = Uri.encodeComponent(mailAddress);
    String subject = Uri.encodeComponent("Mail from care-life");
    String body = Uri.encodeComponent("Thank you for your contribution");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (!await launchUrl(mail)) {
      sendToastMessage(message: 'error launch in mail');
    }
  }

  /// to call for particular user
  Future<void> launchPhoneCall(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }
}
