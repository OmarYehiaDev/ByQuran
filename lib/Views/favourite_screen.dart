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
          ? const Center(child: CircularProgressIndicator())
          : bookController.bookMarks.isEmpty
              ? Center(
                  child: CustomText(
                    text: "لا توجد سور مفضلة حتى الآن",
                    fontSize: 26.sp,
                    color: (ThemeProvider.themeOf(context).id == "dark_theme")
                        ? blueLightColor
                        : mainColor,
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
                                          'bookPages': bookController.bookMarks.toList()[index].id,
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
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(
                                              7,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              bookController.bookMarks.toList()[index].bookTitle,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                height: 1.0,
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
                                              child: Image.network(
                                                imagesUrl +
                                                    bookController.bookMarks
                                                        .toList()[index]
                                                        .bookCoverImg,
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
}
