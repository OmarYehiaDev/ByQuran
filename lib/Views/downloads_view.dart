// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Services/services.dart';
import 'package:welivewithquran/Views/details_screen.dart';
import 'package:welivewithquran/models/ebook_org.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class DownloadsScreen extends StatefulWidget {
  final BookController ctrl;
  DownloadsScreen({required this.ctrl});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  Set<Ebook> bookSet = Set<Ebook>();

  void setValue() {
    setState(() {
      bookSet = widget.ctrl.downloadedList.value;
    });
  }

  @override
  void initState() {
    setValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: (ThemeProvider.themeOf(context).id == "dark_theme") ? null : blueDarkColor,
        elevation: 0,
        backgroundColor: (ThemeProvider.themeOf(context).id == "dark_theme")
            ? blueDarkColor
            : Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: double.infinity,
        //height: double.infinity,
        decoration: BoxDecoration(
          color: (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : whiteColor,
          // image: (ThemeProvider.themeOf(context).id == "dark_theme")
          //     ? null
          //     : DecorationImage(
          //         image: AssetImage('assets/images/main_background1.png'),
          //         fit: BoxFit.cover,
          //       ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            CustomText(
              text: "التحميلات",
              fontSize: 38.sp,
              color:
                  (ThemeProvider.themeOf(context).id == "dark_theme") ? blueLightColor : mainColor,
            ),
            bookSet.isEmpty
                ? Container(
                    color:
                        (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : null,
                    child: Center(
                      child: CustomText(
                        text: "لا توجد تحميلات حتى الآن",
                        fontSize: 26.sp,
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? blueLightColor
                            : mainColor,
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: bookSet.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, //2
                          childAspectRatio: .9, //.7
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => DetailsScreen(),
                                arguments: [
                                  {
                                    'id': bookSet.toList()[index].id,
                                  },
                                  {
                                    'title': bookSet.toList()[index].bookTitle,
                                  },
                                  {
                                    'bookCover': bookSet.toList()[index].bookCoverImg,
                                  },
                                  {
                                    'bookPages': bookSet.toList()[index].bookPages,
                                  },
                                  {
                                    'bookDescription': bookSet.toList()[index].bookDescription,
                                  },
                                  {
                                    'bookFile': bookSet.toList()[index].bookFileUrl,
                                  },
                                  {
                                    'authorName': bookSet.toList()[index].authorName,
                                  },
                                  {
                                    'categoryName': bookSet.toList()[index].categoryName,
                                  },
                                  {
                                    "book": bookSet.toList()[index],
                                  },
                                  {
                                    "books": widget.ctrl,
                                  },
                                  {
                                    "condition": false,
                                  },
                                ],
                              );
                              // Navigator.of(context).push(_createRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                height: 0.1.sh,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          bookSet.toList()[index].bookTitle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.5.sp,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        /// lib book width
                                        // width: 130.w,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                imagesUrl + bookSet.toList()[index].bookCoverImg,
                                            fit: BoxFit.fill,
                                            progressIndicatorBuilder:
                                                (context, url, downloadProgress) => Padding(
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
                                          //   imagesUrl + bookSet.toList()[index].bookCoverImg,
                                          //   fit: BoxFit.fill,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  // Route _createRoute() {
  BoxDecoration borderSide() {
    return const BoxDecoration(
      border: Border(
        left: BorderSide(
          //                   <--- left side
          color: Colors.black,
          width: 3.0,
        ),
        top: BorderSide(
          //                    <--- top side
          color: Colors.black,
          width: 3.0,
        ),
      ),
    );
  }
}
