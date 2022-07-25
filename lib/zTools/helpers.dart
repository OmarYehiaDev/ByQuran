import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class Helper {
  /// prepare for finding local path:
  static Future<String> getDir(String localPath) async {
    String path = '';
    if (Platform.isAndroid) {
      path = '/sdcard/' + localPath;
    } else {
      var directory = await getApplicationDocumentsDirectory();
      path = directory.path + Platform.pathSeparator + localPath;
    }
    final dir = Directory(path);
    bool hasExist = await dir.exists();
    if (!hasExist) {
      dir.create();
    }
    return path;
  }

  /// Get Filename from URL:
  static String getFileName(String fileUrl) {
    return fileUrl.substring(fileUrl.lastIndexOf('/') + 1);
  }

  /// for check and requesting device's permissions :
  static Future getStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted)
          return true;
        else
          return true;
      }
    } else {
      return true;
    }
    return false;
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// Download File By Dio
  static Future<String> downloadFile(url, savePath) async {
    late String download;
    Dio dio = Dio();
    String fileName = url.substring(url.lastIndexOf('/') + 1);
    savePath = await getFilePath(fileName);
    await dio.download(url, savePath, onReceiveProgress: (rec, total) {
      download = ((rec / total) * 100).toString();
    });
    return download;
  }

  static Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    return path;
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// ///

  /// Check Platform
  static String? getPlatform() {
    if (Platform.isAndroid) {
      return 'isAndroid';
    } else if (Platform.isIOS) {
      return 'isIOS';
    } else if (Platform.isMacOS) {
      return 'isMacOS';
    }
    return null;
    // Platform.isAndroid
    // Platform.isIOS
    // Platform.isFuchsia
    // Platform.isLinux
    // Platform.isMacOS
    // Platform.isWindows
  }
}

class zTools {
  // Download Files
  static Future<File> downloadFile(String url, String filename) async {
    var httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      final dir =
          await getTemporaryDirectory(); //(await getApplicationDocumentsDirectory()).path;
      File file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes);
      print('downloaded file path = ${file.path}');
      return file;
    } catch (error) {
      print('pdf downloading error = $error');
      return File('');
    }
  }

  static Future<File> downloadFile2(String url, String filename) async {
    http.Client _client = http.Client();
    var req = await _client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<String> downloadFile3(
      String url, String fileName, String dir) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url + '/' + fileName;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  // Share Function
  static Future<void> share(
      String title, String text, String linkUrl, String chooserTitle) async {
    await FlutterShare.share(
        title: title, text: text, linkUrl: linkUrl, chooserTitle: chooserTitle);
  }

  // Get Download path
  static Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print('Cannot get download folder path');
    }
    return directory?.path;
  }
}

class PDFApi {
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    return _storeFile(path, bytes);
  }

  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  // static Future<File?> pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result == null) return null;
  //   return File(result.paths.first.toString());
  // }

  // static Future<File> loadFirebase(String url) async {
  //   try {
  //     final refPDF = FirebaseStorage.instance.ref().child(url);
  //     final bytes = await refPDF.getData();

  //     return _storeFile(url, bytes);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}

Future<String> getFilePath(fileName) async {
  String path = '';
  Directory dir = await getApplicationDocumentsDirectory();
  path = '${dir.path}/$fileName';
  return path;
}

Future<String> getDir(String localPath) async {
  String path = '';
  if (Platform.isAndroid) {
    path = '/sdcard/' + localPath;
  } else {
    var directory = await getApplicationDocumentsDirectory();
    path = directory.path + Platform.pathSeparator + localPath;
  }
  final dir = Directory(path);
  bool hasExist = await dir.exists();
  if (!hasExist) {
    dir.create();
  }
  return path;
}

// <uses-permission android:name="android.permission.INTERNET" />
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

// <application
// android:requestLegacyExternalStorage="true"
