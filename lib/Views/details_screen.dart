// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Services/services.dart';
import 'package:welivewithquran/Views/read_book_online.dart';
import 'package:welivewithquran/Views/read_book_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';
import 'package:welivewithquran/zTools/helpers.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import '../models/ebook_org.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key}) : super(key: key);

  final dynamic argumentData = Get.arguments;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final prefs = Get.find<SharedPreferences>();

  dynamic argumentData = Get.arguments;
  GetStorage storage = GetStorage();

  /// -------- Download Vars ---------------
  bool downloading = false;
  bool? isDownloaded;
  String progress = '';

  /// ---------------------------------------

  String fileUrl = '';
  String _fileName = '';
  @override
  void initState() {
    super.initState();
    isDownloaded = storage.read(
          argumentData[8]['book'].bookTitle,
        ) ??
        prefs.getBool(argumentData[8]['book'].bookTitle) ??
        false;
    fileUrl = argumentData[5]['bookFile'].toString();
    Future.microtask(
      () async => _fileName = storage.read(
            argumentData[5]['bookFile'].toString() + argumentData[8]['book'].bookTitle,
          ) ??
          await getFilePath(fileUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    Ebook book = argumentData[8]['book'];
    BookController ctrl = Get.put(argumentData[9]['books']);
    bool isFromFavs = argumentData[10]["condition"];
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          leading: const SizedBox(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/icons/back_arrow.svg'),
              ),
            )
          ],
          title: Text(
            'تفاصيل',
            style: TextStyle(
              fontSize: 24.sp,
              color: (ThemeProvider.themeOf(context).id == "dark_theme") ? whiteColor : mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : whiteColor,
            // image: (ThemeProvider.themeOf(context).id == "dark_theme")
            //     ? null
            //     : DecorationImage(
            //         image: AssetImage('assets/images/main_background1.png'),
            //         fit: BoxFit.cover,
            //       ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),

                /// Appbar

                /// ------------------------------ Details ------------------------
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CustomText(
                                    text: argumentData[1]["title"].toString().split(" ").length > 4
                                        ? argumentData[1]["title"]
                                                .toString()
                                                .split(" ")
                                                .getRange(0, 4)
                                                .join(" ") +
                                            "\n" +
                                            argumentData[1]["title"]
                                                .toString()
                                                .split(" ")
                                                .getRange(
                                                    4,
                                                    argumentData[1]["title"]
                                                        .toString()
                                                        .split(" ")
                                                        .length)
                                                .join(" ")
                                        : argumentData[1]["title"].toString(),
                                    fontSize: 17.sp,
                                    color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                        ? whiteColor
                                        : mainColor,
                                    alignment: TextAlign.center,
                                  ),
                                ),

                                /// ------------------------------ Favorite Button ------------------------
                                Obx(
                                  () => IconButton(
                                    onPressed: () async {
                                      bool res = false;
                                      if (isFromFavs) {
                                        if (storage.read(
                                                  ctrl.bookList.value
                                                          .singleWhere((e) => e.id == book.id)
                                                          .bookTitle +
                                                      ctrl.bookList.value
                                                          .singleWhere((e) => e.id == book.id)
                                                          .id,
                                                ) !=
                                                null &&
                                            storage.read(
                                              ctrl.bookList.value
                                                      .singleWhere((e) => e.id == book.id)
                                                      .bookTitle +
                                                  ctrl.bookList.value
                                                      .singleWhere((e) => e.id == book.id)
                                                      .id,
                                            )) {
                                          res = await ctrl.removeEbook(
                                            ctrl.bookMarks.value
                                                .singleWhere((e) => e.id == book.id)
                                                .id,
                                          );
                                        } else {
                                          res = await ctrl.addEbook(
                                            ctrl.bookList.value
                                                .singleWhere(
                                                  (e) => e.id == book.id,
                                                )
                                                .id,
                                          );
                                        }
                                      } else {
                                        if (ctrl.bookList.value
                                            .singleWhere((e) => e.id == book.id)
                                            .inFavorites) {
                                          res = await ctrl.removeEbook(
                                            ctrl.bookList.value
                                                .singleWhere((e) => e.id == book.id)
                                                .id,
                                          );
                                        } else {
                                          res = await ctrl.addEbook(
                                            ctrl.bookList.value
                                                .singleWhere(
                                                  (e) => e.id == book.id,
                                                )
                                                .id,
                                          );
                                        }
                                      }
                                      res ? setState(() {}) : () {};
                                    },
                                    icon: Icon(Icons.favorite),
                                    color: storage.read(
                                                  ctrl.bookList.value
                                                          .singleWhere((e) => e.id == book.id)
                                                          .bookTitle +
                                                      ctrl.bookList.value
                                                          .singleWhere((e) => e.id == book.id)
                                                          .id,
                                                ) !=
                                                null &&
                                            storage.read(
                                              ctrl.bookList.value
                                                      .singleWhere((e) => e.id == book.id)
                                                      .bookTitle +
                                                  ctrl.bookList.value
                                                      .singleWhere((e) => e.id == book.id)
                                                      .id,
                                            )
                                        ? (ThemeProvider.themeOf(context).id == "dark_theme")
                                            ? blueLightColor
                                            : blueDarkColor
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// --------------------- Share Button --------------------------
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () async {
                              await Share.share(
                                "تدبر كتاب \"${argumentData[1]["title"]}\" :\n $fileUrl",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: 'الصفحات: ',
                                fontSize: 16.sp,
                                color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                    ? whiteColor
                                    : mainColor,
                              ),
                              const SizedBox(width: 5),
                              CustomText(
                                text: argumentData[3]['bookPages'].toString(),
                                fontSize: 15.sp,
                                color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                    ? whiteColor
                                    : mainColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // CustomText(
                              //   text: 'المؤلف:',
                              //   fontSize: 16.sp,
                              //   color: mainColor,
                              // ),
                              // const SizedBox(
                              //   width: 5,
                              // ),
                              CustomText(
                                text: argumentData[6]['authorName'].toString(),
                                fontSize: 15.sp,
                                color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                    ? whiteColor
                                    : mainColor,
                              ),
                            ],
                          ),
                        ),
                      ].reversed.toList(),
                    ),
                    SizedBox(
                      width: context.width,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: CachedNetworkImage(
                                imageUrl: imagesUrl + argumentData[2]['bookCover'].toString(),
                                fit: BoxFit.contain,
                                width: 0.525.sw,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Padding(
                                  padding: const EdgeInsets.all(32.0).add(
                                    EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                                  ),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: blueDarkColor,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              // Image.network(
                              // imagesUrl + argumentData[2]['bookCover'].toString(),
                              //   width: 0.525.sw,
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          // CustomText(
                                          //   text: 'قسم: ',
                                          //   fontSize: 16.sp,
                                          //   color: mainColor,
                                          // ),
                                          // const SizedBox(
                                          //   width: 5,
                                          // ),
                                          CustomText(
                                            text: argumentData[7]['categoryName'].toString(),
                                            fontSize: 15.sp,
                                            color:
                                                (ThemeProvider.themeOf(context).id == "dark_theme")
                                                    ? whiteColor
                                                    : mainColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //(progress != 'Completed' || fileExists == false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (isDownloaded == null || !isDownloaded!)

                                      /// ------------------------------ Download Book ------------------------
                                      ? GestureDetector(
                                          onTap: () async {
                                            await Helper.getStoragePermission();
                                            print(fileUrl);
                                            await downloadFile(fileUrl);
                                          },
                                          child: Container(
                                            height: 50.h,
                                            padding:
                                                downloading ? EdgeInsets.zero : EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: downloading
                                                  ? Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 6.0,
                                                            ),
                                                            child: Text(
                                                              "${progress.isEmpty ? 0 : progress} %",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                height: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          progress != "100.0"
                                                              ? SizedBox(
                                                                  child: CircularProgressIndicator(
                                                                    color: Colors.white,
                                                                  ),
                                                                )
                                                              : SizedBox.shrink(),
                                                        ],
                                                      ),
                                                    )
                                                  : CustomText(
                                                      text: 'تحميل الكتاب',
                                                      fontSize: 18.sp,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                          ),
                                        )

                                      /// --------------------------------  Read Book --------------------------
                                      : GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => const ReadBookScreen(
                                                fromSearch: false,
                                              ),
                                              arguments: [
                                                {
                                                  'id': argumentData[0]['id'],
                                                  'title': argumentData[1]['title'].toString(),
                                                  'description': argumentData[4]['bookDescription'],
                                                  'pdf': _fileName,
                                                  'author':
                                                      argumentData[6]['authorName'].toString(),
                                                  'condition': argumentData[10]["condition"],
                                                  'book': argumentData[8]["book"],
                                                  'books': argumentData[9]["books"],
                                                  "isHorizontal": book.bookTitle.contains("جدول"),
                                                  "fileUrl": fileUrl,
                                                },
                                              ],
                                            );
                                          },
                                          child: Container(
                                            height: 50.h,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                text: 'قراءة الكتاب',
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => ReadOnlineScreen(fileURL: fileUrl),
                                        fullscreenDialog: true,
                                      );
                                    },
                                    child: Container(
                                      height: 50.h,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional.center,
                                        child: CustomText(
                                          text: 'قراءة بدون تحميل',
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
// ----------------------------------------------------------------

                /// ------------------------------ Divider ------------------------
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  child: Divider(
                    indent: 1.0,
                    endIndent: 1.0,
                    thickness: 2,
                    color: blueLightColor,
                    height: 8,
                  ),
                ),
// ----------------------------------------------------------------

                /// ------------------------------ Read else -----------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'اقرأ أيضًا',
                        fontSize: 18.sp,
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : mainColor,
                      ),
                      Icon(
                        Icons.more_horiz_outlined,
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : mainColor,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                ctrl.popularList.isNotEmpty
                    ? SizedBox(
                        height: 0.3.sh,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ctrl.popularList.length,
                          itemBuilder: (context, index) {
                            Ebook book = ctrl.popularList.value[index];
                            return GestureDetector(
                              onTap: () {
                                Get.back();
                                Get.to(
                                  () => DetailsScreen(),
                                  arguments: [
                                    {
                                      'id': book.id,
                                    },
                                    {
                                      'title': book.bookTitle,
                                    },
                                    {
                                      'bookCover': book.bookCoverImg,
                                    },
                                    {
                                      'bookPages': book.bookPages,
                                    },
                                    {
                                      'bookDescription': book.bookDescription,
                                    },
                                    {
                                      'bookFile': book.bookFileUrl,
                                    },
                                    {
                                      'authorName': book.authorName,
                                    },
                                    {
                                      'categoryName': book.categoryName,
                                    },
                                    {
                                      "book": book,
                                    },
                                    {
                                      "books": ctrl,
                                    },
                                    {
                                      "condition": false,
                                    },
                                    {
                                      'isHorizontal': book.bookTitle.contains("جدول"),
                                    },
                                  ],
                                );
                                // Navigator.of(context).push(_createRoute());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: imagesUrl + book.bookCoverImg,
                                        fit: BoxFit.contain,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) => Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              color: blueDarkColor,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      // Image.network(
                                      //   imagesUrl + book.bookCoverImg,
                                      //   fit: BoxFit.contain,
                                      // ),
                                    ),
                                    Text(
                                      book.authorName,
                                      style: TextStyle(
                                        color: blueColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text(
                                      book.bookTitle.split(" ").length > 4
                                          ? book.bookTitle.split(" ").getRange(0, 4).join(" ") +
                                              "\n" +
                                              book.bookTitle
                                                  .split(" ")
                                                  .getRange(4, book.bookTitle.split(" ").length)
                                                  .join(" ")
                                          : book.bookTitle,
                                      style: TextStyle(
                                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                            ? whiteColor
                                            : mainColor,
                                        fontSize: 16.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? blueDarkColor
                            : null,
                        child: Center(
                          child: CustomText(
                            alignment: TextAlign.center,
                            text: "لا توجد مقترحات",
                            fontSize: 16.sp,
                            color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                ? blueLightColor
                                : mainColor,
                          ),
                        ),
                      ),
// ----------------------------------------------------------------
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getFilePath(String url) async {
    String fileName = url.substring(url.lastIndexOf('/') + 1);
    final dir = await getExternalStorageDirectory();
    File file = File('${dir!.path}/$fileName');
    return file.path;
  }

  Future<void> downloadFile(String url) async {
    if (url.contains("localhost")) {
      Get.snackbar("خطأ", "لا يمكن تحميل هذا الملف");
      return;
    }

    BookController ctrl = Get.put(argumentData[9]['books']);
    try {
      var httpClient = HttpClient();
      String fileName = url.substring(url.lastIndexOf('/') + 1);
      final dir = await getExternalStorageDirectory();
      await Helper.getStoragePermission();
      setState(() {
        downloading = true;
      });
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(
        response,
        onBytesReceived: (received, total) {
          print('Received: $received , Total: $total');
          setState(() {
            progress = ((received / total!) * 100).toStringAsFixed(1);
          });
        },
      );
      File file = File('${dir!.path}/$fileName');
      final finalFile = await file.writeAsBytes(bytes);
      // File finalFile = await zTools.downloadFile(url, fileName);
      setState(() {
        downloading = false;
        progress = 'Completed';
        _fileName = finalFile.path;
        isDownloaded = true;
      });
      await storage.write(argumentData[8]['book'].bookTitle, true);

      await prefs.setBool(argumentData[8]['book'].bookTitle, true);
      await storage.write(
        argumentData[5]['bookFile'].toString() + argumentData[8]['book'].bookTitle,
        finalFile.path,
      );
      await ctrl.getDownloaded();
    } catch (e) {
      print(e.toString());
    }
    print('Download completed');
  }
}
