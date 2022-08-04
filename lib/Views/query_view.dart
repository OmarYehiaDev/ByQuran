import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/models/search_query.dart';
import 'package:welivewithquran/services/services.dart';
import 'package:welivewithquran/zTools/colors.dart';

class QueryView extends StatelessWidget {
  final SearchQuery item;
  final String query;
  const QueryView({
    Key? key,
    required this.item,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final document = parse(item.pageText);

    return Scaffold(
      backgroundColor:
          (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : blueBackgroundColor,
      appBar: AppBar(
        title: Text("نتيجة البحث عن كلمة: $query"),
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
              title: Text("سورة " + item.surahTitle),
              trailing: Text("رقم السورة: " + item.surahNum),
            ),
            SizedBox(
              height: 0.3.sh,
              child: Card(
                child: Image.network(
                  imagesUrl + item.pageImg,
                ),
              ),
            ),
            ListTile(
              title: Text("نتيجة البحث:"),
              subtitle: Text("\"${parse(document.body?.text).body!.text.trim()}\""),
              trailing: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(blueColor),
                ),
                child: Text("تحميل"),
                onPressed: () {
                  print(item.pageFile);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
