import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:welivewithquran/zTools/colors.dart';

class MoshafScreen extends StatefulWidget {
  final String fileURL;
  const MoshafScreen({super.key, required this.fileURL});

  @override
  State<MoshafScreen> createState() => _MoshafScreenState();
}

class _MoshafScreenState extends State<MoshafScreen> {
  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blueDarkColor,
          actions: [
            TextButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(widget.fileURL),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception(
                    'Could not launch ${widget.fileURL}',
                  );
                }
              },
              child: Text(
                "فتح في المتصفح",
                style: TextStyle(color: whiteColor),
              ),
            ),
          ],
        ),
        body: WebView(
          initialUrl: widget.fileURL,
        ),
      ),
    );
  }
}
