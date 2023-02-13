import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Views/read_book_screen.dart';
import 'package:welivewithquran/models/search_query.dart';
import 'package:welivewithquran/zTools/colors.dart';

class QueryView extends StatefulWidget {
  final SearchQuery item;
  final String query;
  const QueryView({
    Key? key,
    required this.item,
    required this.query,
  }) : super(key: key);

  @override
  State<QueryView> createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  GetStorage storage = GetStorage();

  /// -------- Download Vars ---------------
  bool downloading = false;
  bool? isDownloaded;
  String progress = '';

  @override
  void initState() {
    super.initState();
    isDownloaded = storage.read(widget.item.surahTitle + "search") ?? false;
  }

  // Future<void> downloadFile(String url) async {
  //   try {
  //     String fileName = url.substring(url.lastIndexOf('/') + 1);
  //     await Helper.getStoragePermission();
  //     setState(() {
  //       downloading = true;
  //     });
  //     File finalFile = await zTools.downloadFile(url, fileName);
  //     setState(() {
  //       downloading = false;
  //       progress = 'Completed';
  //       isDownloaded = true;
  //     });
  //     await storage.write(widget.item.surahTitle + "search", true);
  //     await storage.write(widget.item.pageFile + widget.item.surahTitle + "search", finalFile.path);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   print('Download completed');
  // }

  @override
  Widget build(BuildContext context) {
    final document = parse(widget.item.pageText);

    return Scaffold(
      backgroundColor:
          (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : whiteColor,
      appBar: AppBar(
        title: Text("نتيجة البحث عن كلمة: ${widget.query}"),
        centerTitle: true,
        foregroundColor: (ThemeProvider.themeOf(context).id == "dark_theme") ? null : blueDarkColor,
        elevation: 0,
        backgroundColor: (ThemeProvider.themeOf(context).id == "dark_theme")
            ? blueDarkColor
            : Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              title: Text(widget.item.surahTitle),
              trailing: Text("ترتيب السورة: " + widget.item.surahNum),
            ),
            ListTile(
              leading: downloading
                  ? CircularProgressIndicator(
                      color: blueColor,
                    )
                  : null,
              title: Text("نتيجة البحث:"),
              subtitle: Text("\"${parse(document.body?.text).body!.text.trim()}\""),
              trailing: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(blueColor),
                ),
                child: Text("قراءة"),
                onPressed: () async {
                  Get.off(
                    () => const ReadBookScreen(
                      fromSearch: true,
                    ),
                    arguments: [
                      {
                        'title': widget.item.surahTitle,
                        'id': widget.item.surahNum,
                        'page': int.parse(widget.item.pageNum),
                        'description': parse(document.body?.text).body!.text.trim(),
                        'pdf': widget.item.pageFile,
                        'author': "د. فاطمة بنت عمر نصيف",
                      },
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
