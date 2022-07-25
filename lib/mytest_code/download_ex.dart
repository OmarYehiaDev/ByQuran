import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// value between 0 - 1 (shows progress, 0=0%, 1=100%)
  /// if null -> infinite spinning
  /// if value goes above 1 -> shows full circle like 1
  /// if 0 -> progress disappears
  double? progress = null;

  String status = 'Not Downloaded';

  /// random download file for demonstration purposes
  /// replace with any file you want to download
  // final url = 'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_1000MG.mp3';
  // final url = 'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_1920_18MG.mp4';
  final url = 'https://speed.hetzner.de/100MB.bin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Progress'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _downloadButtonPressed,
              child: const Text('Download'),
            ),
            const SizedBox(height: 20,),
            CircularProgressIndicator(
              value: progress,
            ),
            const SizedBox(height: 20,),
            Text(status),
          ],
        ),
      ),
    );
  }

  void _downloadButtonPressed() async {
    /// when download first called it takes a bit of time to communicate with server.
    /// While that is happening, make circle just spin eternally
    setState(() { progress = null; });

    final request = Request('GET', Uri.parse(url));
    /// calling Client().send() instead of get(url) method.
    /// Reason: send() gives you a stream, and you’re going to listen to the
    /// stream of bytes as it downloads the file from the server
    final StreamedResponse response = await Client().send(request);

    /// response coming from the server contains a header called Content-Length,
    /// which includes the total size of the file in bytes
    final contentLength = response.contentLength;
    // sometimes the server doesn't return this value or sometimes the header gets stripped away.
    // If that’s the case then contentLength will be null.
    // That makes it more difficult to show your users the download progress.
    // There are a couple of options:
    //   - If you have control of the server, you can set the x-decompressed-content-length header
    //     with the file size before you send it. That header seems to stay put.
    //     On the client side you could retrieve the content length like this:
    //       final contentLength = double.parse(response.headers['x-decompressed-content-length']);
    //   - Another option is to just show the cumulative number of bytes that are being downloaded.
    //     Since the final total is not known, the user still won’t know how long they have to wait,
    //     but at least it will be more informative than an eternal spinning circle.

    /// Now that we have response from server, stop the spinning indicator & set it to 0
    setState(() {
      progress = 0.000001;
      status = 'Download Started';
    });

    /// Initialize variable to save the download in.
    /// Array stores the file in memory before you save to storage.
    /// Since the length of this array is the number of bytes that have been
    /// downloaded, use this to track the progress of the download.
    List<int> bytes = [];

    /// place to store the file
    final file = await _getFile('video.mp4');

    response.stream.listen(
          (List<int> newBytes) {
        // update progress
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        setState(() {
          progress = downloadedLength.toDouble() / (contentLength ?? 1);
          status = 'Progress: ${((progress ?? 0)*100).toStringAsFixed(2)} %';
        });
        print('progress: $progress');
      },
      onDone: () async {
        // save file
        setState(() {
          progress = 1;
          status = 'Download Finished';
        });
        await file.writeAsBytes(bytes);

        /// file has been downloaded
        /// show success to user
        debugPrint('Download finished');
      },
      onError: (e) {
        /// if user loses internet connection while downloading the file, causes an error.
        /// You can decide what to do about that in onError.
        /// Setting cancelOnError to true will cause the StreamSubscription to get canceled.
        debugPrint(e);
      },
      cancelOnError: true,
    );

    /// using Flutter package "dio":
    //      Dio dio = Dio();
    //      dio.download(urlOfFileToDownload, '$dir/$filename',
    //         onReceiveProgress(received,total) {
    //         setState(() {
    //           int percentage = ((received / total) * 100).floor();
    //         });
    //      });


  }

  /// Finds an appropriate place on the user’s device to put the file.
  /// In this case we are choosing to use the temp directory.
  /// You could also chose the documents directory or somewhere else.
  /// This method is using the path_provider package to get that location.
  Future<File> _getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    // final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$filename');
  }

}

