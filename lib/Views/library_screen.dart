import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Services/services.dart';
import 'package:welivewithquran/Views/details_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class LibraryScreen extends StatelessWidget {
  final BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    print(bookController.bookList.isEmpty);
    return Obx(
      () => bookController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: blueColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: bookController.getAll,
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
                      text: 'المكتبة',
                      fontSize: 38.sp,
                      color: (ThemeProvider.themeOf(context).id == "dark_theme")
                          ? blueLightColor
                          : mainColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: bookController.bookList.length,
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
                                      'id': bookController.bookList[index].id,
                                    },
                                    {
                                      'title': bookController.bookList[index].bookTitle,
                                    },
                                    {
                                      'bookCover': bookController.bookList[index].bookCoverImg,
                                    },
                                    {
                                      'bookPages': bookController.bookList[index].bookPages,
                                    },
                                    {
                                      'bookDescription':
                                          bookController.bookList[index].bookDescription,
                                    },
                                    {
                                      'bookFile': bookController.bookList[index].bookFileUrl,
                                    },
                                    {
                                      'authorName': bookController.bookList[index].authorName,
                                    },
                                    {
                                      'categoryName': bookController.bookList[index].categoryName,
                                    },
                                    {
                                      "book": bookController.bookList[index],
                                    },
                                    {
                                      "books": bookController,
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
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: Text(
                                            bookController.bookList[index].bookTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.5.sp,
                                              height: 1.5,
                                            ),
                                            textAlign: TextAlign.center,
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
                                                  bookController.bookList[index].bookCoverImg,
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
                                              errorWidget: (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                            // Image.network(
                                            //   imagesUrl +
                                            //       bookController.bookList[index].bookCoverImg,
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

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

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
