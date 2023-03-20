class BookTools {
  static const appName = 'لنحيا بالقرآن';
  static const bookHeight = 260;
  static const bookWidth = 130;

  static String stripHtml(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
}

class Command {
  static final all = [email, browser1, browser2];
  static const email = 'write email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
}
