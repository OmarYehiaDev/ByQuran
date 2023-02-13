import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadOnlineScreen extends StatefulWidget {
  final String fileURL;
  const ReadOnlineScreen({super.key, required this.fileURL});

  @override
  State<ReadOnlineScreen> createState() => _ReadOnlineScreenState();
}

class _ReadOnlineScreenState extends State<ReadOnlineScreen> {
  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: showWidget
            ? SfPdfViewer.network(
                widget.fileURL,
                pageLayoutMode: PdfPageLayoutMode.single,
                onDocumentLoaded: (doc) {
                  setState(() {
                    showWidget = true;
                  });
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
