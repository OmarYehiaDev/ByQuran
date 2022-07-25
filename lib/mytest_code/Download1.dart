import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

void main()=> runApp(DownloadFile());


class DownloadFile extends StatefulWidget {
  @override
  State createState() {
    return _DownloadFileState();
  }
}

class _DownloadFileState extends State {
  var imageUrl =
      "https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";

  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future downloadFile() async {
    try {
      Dio dio = Dio();

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr =
          "Downloading Image : $rec" ;

        });


      } );
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Download File"),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: downloading
              ? Container(
            height: 250,
            width: 250,
            child: Card(
              color: Colors.pink,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    downloadingStr,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
              : Container(
            height: 250,
            width: 250,
            child: Center(
              child: Image.file(
                File(savePath),
                height: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}