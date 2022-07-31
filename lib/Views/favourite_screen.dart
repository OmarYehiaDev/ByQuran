import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
          : RefreshIndicator(
              onRefresh: bookController.getBookmarks,
              child: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: double.infinity,
                //height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
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
                      color: mainColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: bookController.bookList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, //2
                              childAspectRatio: .5, //.7
                              mainAxisExtent: 200,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailsScreen(), arguments: [
                                    {
                                      'id': bookController.bookList[index].id,
                                    },
                                    {
                                      'title': bookController
                                          .bookList[index].bookTitle,
                                    },
                                    {
                                      'bookCover': bookController
                                          .bookList[index].bookCoverImg,
                                    },
                                    {
                                      'bookPages':
                                          bookController.bookList[index].id,
                                    },
                                    {
                                      'bookDescription': bookController
                                          .bookList[index].bookDescription,
                                    },
                                    {
                                      'bookFile': bookController
                                          .bookList[index].bookFileUrl,
                                    },
                                    {
                                      'authorName': bookController
                                          .bookList[index].authorName,
                                    },
                                    {
                                      'categoryName': bookController
                                          .bookList[index].categoryName,
                                    },
                                    {
                                      "book": index,
                                    },
                                    {
                                      "books": bookController,
                                    },
                                  ]);
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
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                            child: Text(
                                          bookController
                                              .bookList[index].bookTitle,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              height: 1.0),
                                        )),
                                      ),
                                      SizedBox(height: 7.h),
                                      Expanded(
                                        child: SizedBox(
                                          height: 210.h,

                                          /// lib book width
                                          // width: 130.w,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            child: Image.network(
                                              imagesUrl +
                                                  bookController.bookList[index]
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
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
