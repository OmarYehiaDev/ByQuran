import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Services/services.dart';
import 'package:welivewithquran/Views/details_screen.dart';
import 'package:welivewithquran/Models/category.dart';
import 'package:welivewithquran/models/ebook_org.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class CategoryScreen extends StatelessWidget {
  final Category cat;
  final BookController ctrl;
  CategoryScreen({required this.cat, required this.ctrl});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70.h),
            CustomText(
              text: cat.categoryName,
              fontSize: 38.sp,
              color:
                  (ThemeProvider.themeOf(context).id == "dark_theme") ? blueLightColor : mainColor,
            ),
            FutureBuilder<List<Ebook>?>(
              future: DataServices.getEbooksFromCat(cat.cid),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  List<Ebook> bookList = snapshot.data ?? [];
                  return bookList.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7.0),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: bookList.length,
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
                                          'id': bookList[index].id,
                                        },
                                        {
                                          'title': bookList[index].bookTitle,
                                        },
                                        {
                                          'bookCover': bookList[index].bookCoverImg,
                                        },
                                        {
                                          'bookPages': bookList[index].id,
                                        },
                                        {
                                          'bookDescription': bookList[index].bookDescription,
                                        },
                                        {
                                          'bookFile': bookList[index].bookFileUrl,
                                        },
                                        {
                                          'authorName': bookList[index].authorName,
                                        },
                                        {
                                          'categoryName': bookList[index].categoryName,
                                        },
                                        {
                                          "book": bookList[index],
                                        },
                                        {
                                          "books": ctrl,
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
                                            bookList[index].bookTitle,
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
                                                imagesUrl + bookList[index].bookCoverImg,
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
                      : Container(
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? blueDarkColor
                              : null,
                          child: Center(
                            child: CustomText(
                              alignment: TextAlign.center,
                              text: "لا توجد سور في هذا القسم حتى الآن",
                              fontSize: 26.sp,
                              color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                  ? blueLightColor
                                  : mainColor,
                            ),
                          ),
                        );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: blueColor,
                  ),
                );
              },
            ),
          ],
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
