// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Services/services.dart';
import 'package:welivewithquran/Views/read_book_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';
import 'package:welivewithquran/zTools/helpers.dart';

import '../models/ebook_org.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key}) : super(key: key);

  final dynamic argumentData = Get.arguments;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
        false;
    fileUrl = argumentData[5]['bookFile'].toString();
    _fileName = storage.read(
          argumentData[5]['bookFile'].toString() + argumentData[8]['book'].bookTitle,
        ) ??
        "";
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
            color: (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : mainColor,
            image: (ThemeProvider.themeOf(context).id == "dark_theme")
                ? null
                : DecorationImage(
                    image: AssetImage('assets/images/main_background1.png'),
                    fit: BoxFit.cover,
                  ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),

                /// Appbar

                /// ------------------------------ Details ------------------------
                SizedBox(
                  height: 0.34.sh,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: argumentData[1]['title'].toString(),
                                  fontSize: 20.sp,
                                  color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                      ? whiteColor
                                      : mainColor,
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
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Image.network(
                                  imagesUrl + argumentData[2]['bookCover'].toString(),
                                  // height: 210.h, //210
                                  // width: 120.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            text: 'الصفحات: ',
                                            fontSize: 16.sp,
                                            color:
                                                (ThemeProvider.themeOf(context).id == "dark_theme")
                                                    ? whiteColor
                                                    : mainColor,
                                          ),
                                          const SizedBox(width: 5),
                                          CustomText(
                                            text: argumentData[3]['bookPages'].toString(),
                                            fontSize: 15.sp,
                                            color:
                                                (ThemeProvider.themeOf(context).id == "dark_theme")
                                                    ? whiteColor
                                                    : mainColor,
                                          ),
                                        ],
                                      ),
                                      Row(
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
                                            color:
                                                (ThemeProvider.themeOf(context).id == "dark_theme")
                                                    ? whiteColor
                                                    : mainColor,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
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
                            ),
                            //(progress != 'Completed' || fileExists == false)
                            (isDownloaded == null || !isDownloaded!)

                                /// ------------------------------ Download Book ------------------------
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Helper.getStoragePermission();
                                        print(fileUrl);
                                        await downloadFile(fileUrl);
                                      },
                                      child: Container(
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            text: 'تحميل الكتاب',
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                /// --------------------------------  Read Book --------------------------
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            () => const ReadBookScreen(
                                                  fromSearch: false,
                                                ),
                                            arguments: [
                                              {
                                                'title': argumentData[1]['title'].toString(),
                                                'description': argumentData[4]['bookDescription'],
                                                'pdf': _fileName,
                                                'author': argumentData[6]['authorName'].toString(),
                                              },
                                            ]);
                                      },
                                      child: Container(
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Center(
                                          child: CustomText(
                                            text: 'قراءة الكتاب',
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
// ----------------------------------------------------------------

                /// ------------------------------ Divider ------------------------
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Divider(indent: 1.0, endIndent: 1.0, thickness: 2, color: blueLightColor),
                ),
// ----------------------------------------------------------------

                /// ------------------------------ Read else -----------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'اقرأ ايضا',
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
                ctrl.featuredList.isNotEmpty
                    ? SizedBox(
                        height: 0.3.sh,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ctrl.featuredList.length,
                          itemBuilder: (context, index) {
                            Ebook book = ctrl.featuredList.value[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      imagesUrl + book.bookCoverImg,
                                      fit: BoxFit.fill,
                                      height: 190.h,
                                      width: 120.w,
                                    ),
                                  ),
                                  Text(
                                    book.authorName,
                                    style: TextStyle(
                                      color: blueColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    book.bookTitle,
                                    style: TextStyle(
                                      color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                          ? whiteColor
                                          : mainColor,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
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

  Future<void> downloadFile(String url) async {
    BookController ctrl = Get.put(argumentData[9]['books']);
    try {
      String fileName = url.substring(url.lastIndexOf('/') + 1);
      await Helper.getStoragePermission();
      setState(() {
        downloading = true;
      });
      File finalFile = await zTools.downloadFile(url, fileName);
      setState(() {
        downloading = false;
        progress = 'Completed';
        _fileName = finalFile.path;
        isDownloaded = true;
      });
      await storage.write(argumentData[8]['book'].bookTitle, true);
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
