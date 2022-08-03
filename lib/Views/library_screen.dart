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
          ? const Center(child: CircularProgressIndicator())
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
                      : mainColor,
                  image: (ThemeProvider.themeOf(context).id == "dark_theme")
                      ? null
                      : DecorationImage(
                          image: AssetImage('assets/images/main_background1.png'),
                          fit: BoxFit.cover,
                        ),
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
                            crossAxisCount: 3, //2
                            childAspectRatio: .5, //.7
                            mainAxisExtent: 200,
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
                                      'bookPages': bookController.bookList[index].id,
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
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                          child: Text(
                                        bookController.bookList[index].bookTitle,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16.sp, height: 1.0),
                                      )),
                                    ),
                                    SizedBox(height: 7.h),
                                    Expanded(
                                      child: SizedBox(
                                        height: 210.h,

                                        /// lib book width
                                        // width: 130.w,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7.0),
                                          child: Image.network(
                                            imagesUrl + bookController.bookList[index].bookCoverImg,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
