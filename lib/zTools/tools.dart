

class BookTools{
  static const appName= 'لنحيا بالقران';
  static const bookHeight= 260;
  static const bookWidth= 130;

  static String stripHtml(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

}


// Not Used - Can Remove
// class Utils {
//   static void scanText(String rawText) {
//     final text = rawText.toLowerCase();

//     if (text.contains(Command.email)) {
//       final body = _getTextAfterCommand(text: text, command: Command.email);

//       // openEmail(body: body);
//     } else if (text.contains(Command.browser1)) {
//       final url = _getTextAfterCommand(text: text, command: Command.browser1);

//       // openLink(url: url);
//     } else if (text.contains(Command.browser2)) {
//       final url = _getTextAfterCommand(text: text, command: Command.browser2);

//       // openLink(url: url);
//     }
//   }

//   static String? _getTextAfterCommand({
//     required String text,
//     required String command,
//   }) {
//     final indexCommand = text.indexOf(command);
//     final indexAfter = indexCommand + command.length;

//     if (indexCommand == -1) {
//       return null;
//     } else {
//       return text.substring(indexAfter).trim();
//     }
//   }

//   static Future openLink({
//     required String url,
//   }) async {
//     if (url.trim().isEmpty) {
//       await _launchUrl('https://google.com');
//     } else {
//       await _launchUrl('https://$url');
//     }
//   }

//   static Future openEmail({
//     required String body,
//   }) async {
//     final url = 'mailto: ?body=${Uri.encodeFull(body)}';
//     await _launchUrl(url);
//   }

//   static Future _launchUrl(String url) async {
//     // if (await canLaunch(url)) {
//     //   await launch(url);
//     // }
//   }



// }

class Command {
  static final all = [email, browser1, browser2];
  static const email = 'write email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
}