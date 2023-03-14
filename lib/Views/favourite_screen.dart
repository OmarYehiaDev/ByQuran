import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Views/details_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

import '../Controller/ebook_controller.dart';
import '../services/services.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => bookController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: blueColor,
              ),
            )
          : bookController.bookMarks.isEmpty
              ? Container(
                  color: (ThemeProvider.themeOf(context).id == "dark_theme")
                      ? blueDarkColor
                      : whiteColor,
                  child: Center(
                    child: CustomText(
                      text: "لا توجد سور مفضلة حتى الآن",
                      fontSize: 26.sp,
                      color: (ThemeProvider.themeOf(context).id == "dark_theme")
                          ? blueLightColor
                          : mainColor,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: bookController.getBookmarks,
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: double.infinity,
                    //height: double.infinity,
                    decoration: BoxDecoration(
                      color: (ThemeProvider.themeOf(context).id == "dark_theme")
                          ? blueDarkColor
                          : whiteColor,
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
                          text: 'المفضلة',
                          fontSize: 24.sp,
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? blueLightColor
                              : mainColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7.0),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: bookController.bookMarks.length,
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
                                          'id': bookController.bookMarks.toList()[index].id,
                                        },
                                        {
                                          'title':
                                              bookController.bookMarks.toList()[index].bookTitle,
                                        },
                                        {
                                          'bookCover':
                                              bookController.bookMarks.toList()[index].bookCoverImg,
                                        },
                                        {
                                          'bookPages':
                                              bookController.bookMarks.toList()[index].bookPages,
                                        },
                                        {
                                          'bookDescription': bookController.bookMarks
                                              .toList()[index]
                                              .bookDescription,
                                        },
                                        {
                                          'bookFile':
                                              bookController.bookMarks.toList()[index].bookFileUrl,
                                        },
                                        {
                                          'authorName':
                                              bookController.bookMarks.toList()[index].authorName,
                                        },
                                        {
                                          'categoryName':
                                              bookController.bookMarks.toList()[index].categoryName,
                                        },
                                        {
                                          "book": bookController.bookMarks.toList()[index],
                                        },
                                        {
                                          "books": bookController,
                                        },
                                        {
                                          "condition": true,
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
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(
                                                7,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                bookController.bookMarks.toList()[index].bookTitle,
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
                                          SizedBox(height: 7.h),
                                          Expanded(
                                            child: SizedBox(
                                              height: 210.h,

                                              /// lib book width
                                              // width: 130.w,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(7.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: imagesUrl +
                                                      bookController.bookMarks
                                                          .toList()[index]
                                                          .bookCoverImg,
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, url, downloadProgress) => Padding(
                                                    padding: const EdgeInsets.all(32.0).add(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 32, vertical: 8),
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
                                                  errorWidget: (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                                // Image.network(
                                                //   imagesUrl +
                                                //       bookController.bookMarks
                                                //           .toList()[index]
                                                //           .bookCoverImg,
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
                ),
    );
  }
}
