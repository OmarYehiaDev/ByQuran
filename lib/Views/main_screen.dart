import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Views/category_view.dart';
import 'package:welivewithquran/Views/details_screen.dart';
import 'package:welivewithquran/Models/category.dart';
import 'package:welivewithquran/Views/query_view.dart';
import 'package:welivewithquran/models/ebook_org.dart';
import 'package:welivewithquran/models/search_query.dart';
import 'package:welivewithquran/models/surah.dart';
import 'package:welivewithquran/services/services.dart';

import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BookController bookController = Get.put(BookController());

  int currentPage = 0;
  TextEditingController searchController = TextEditingController();
  int selectedSura = 1;

  bool? isLoading = null;
  Surah? surah;
  List<SearchQuery> data = List<SearchQuery>.empty();
  List<Ebook> featuredList = List<Ebook>.empty();
  int groupVal = 0;

  Future<void> setFeatured() async {
    var list = (await DataServices.getFeaturedEbooks())!;
    setState(() {
      featuredList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BookController bookController = Get.put(BookController());

    return Obx(
      () => bookController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: blueColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: bookController.getCats,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: (ThemeProvider.themeOf(context).id == "dark_theme")
                      ? blueDarkColor
                      : blueBackgroundColor,
                  // image:  DecorationImage(
                  //   image:  AssetImage('assets/images/main_background.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: TextFormField(
                              onChanged: (v) {
                                setState(() {
                                  if (searchController.text.isEmpty) {
                                    data = <SearchQuery>[];
                                  }
                                });
                              },
                              controller: searchController,
                              style: TextStyle(
                                color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                    ? blueColor
                                    : mainColor,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'أبحث هنا',
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                      ? blueColor
                                      : mainColor,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    // search
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      switchWidget()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  searchWidget() {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Row(
            children: [
              Radio<int>(
                value: 0,
                groupValue: groupVal,
                onChanged: (value) {
                  setState(() {
                    groupVal = value!;
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              CustomText(
                text: 'بحث فى الكل',
                fontSize: 18.sp,
                color: (ThemeProvider.themeOf(context).id == "dark_theme") ? blueColor : mainColor,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Row(
            children: [
              Radio<int>(
                value: 1,
                groupValue: groupVal,
                onChanged: (value) {
                  setState(() {
                    groupVal = value!;
                  });
                },
              ),
              SizedBox(
                width: 5.w,
              ),
              CustomText(
                text: 'بحث فى سورة',
                fontSize: 18.sp,
                color: (ThemeProvider.themeOf(context).id == "dark_theme") ? blueColor : mainColor,
              ),
              SizedBox(
                width: 20.w,
              ),
              FutureBuilder<List<Surah>?>(
                future: DataServices.getSurahs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    List<Surah> surahList = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff305F72),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          dropdownColor: const Color(0xff305F72),
                          icon: Padding(
                            padding: EdgeInsetsDirectional.only(start: 30.w),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18.0.sp,
                            color: Colors.white,
                          ),
                          value: selectedSura,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSura = newValue!;
                              surah = surahList.firstWhere(
                                (element) => int.parse(element.id) == newValue,
                              );
                            });
                          },
                          items: surahList.map<DropdownMenuItem<int>>((valueItem) {
                            return DropdownMenuItem(
                              value: int.parse(valueItem.id),
                              child: Text(
                                valueItem.surah,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: blueColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h),
          child: InkWell(
            onTap: () async {
              List<SearchQuery> list = (groupVal == 0 && surah == null)
                  ? (await DataServices.searchBooks(
                      searchController.text.trim(),
                    ))!
                  : (await DataServices.searchBooksSpecific(
                      searchController.text.trim(),
                      surah!,
                    ))!;
              setState(() {
                data = list;
                isLoading = false;
              });
            },
            child: Container(
              height: 40.h,
              width: 190.w,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomText(
                  text: 'بحث',
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        (isLoading != null && isLoading!)
            ? Center(
                child: CircularProgressIndicator(
                  color: blueColor,
                ),
              )
            : (data.isEmpty && isLoading == false)
                ? Center(
                    child: Text("لا توجد نتائج بحث"),
                  )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      SearchQuery item = data[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => QueryView(item: item, query: searchController.text),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Card(
                              child: ListTile(
                                leading: Text("${item.surahTitle}"),
                                title: Text("${item.surahTitle} و ترتيبها رقم: ${item.surahNum}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("رقم الصفحة: ${item.pageNum}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
      ],
    );
  }

  mainWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bookController.featuredList.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: blueColor,
                  ),
                ),
              )
            : Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: SizedBox(
                        height: 170,
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: bookController.featuredList.length,
                          options: CarouselOptions(
                            onPageChanged: (page, reason) {
                              setState(() {
                                print(page);
                                currentPage = page;
                              });
                            },
                            viewportFraction: .3,
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIdx) {
                            Ebook book = bookController.featuredList[index];
                            return GestureDetector(
                              onTap: () {
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
                                      'bookPages': book.id,
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
                                      "books": bookController,
                                    },
                                    {
                                      "condition": false,
                                    },
                                  ],
                                );
                                // Navigator.of(context).push(_createRoute());
                              },
                              child: Center(
                                child: Image.network(
                                  imagesUrl + book.bookCoverImg,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 15.h,
                        width: 120.w,
                        child: ListView.builder(
                          itemCount: bookController.featuredList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                              child: CircleAvatar(
                                radius: 8.h,
                                backgroundColor: currentPage == index ? blueColor : blueLightColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

        /// ------------------------------ Latest Books -----------------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            "المضاف أخيرًا",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: SizedBox(
            height: 0.275.sh,
            child:
                // Get Random eBook API
                ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bookController.latestBook.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => DetailsScreen(),
                      arguments: [
                        {
                          'id': bookController.latestBook[index].id,
                        },
                        {
                          'title': bookController.latestBook[index].bookTitle,
                        },
                        {
                          'bookCover': bookController.latestBook[index].bookCoverImg,
                        },
                        {
                          'bookPages': bookController.latestBook[index].id,
                        },
                        {
                          'bookDescription': bookController.latestBook[index].bookDescription,
                        },
                        {
                          'bookFile': bookController.latestBook[index].bookFileUrl,
                        },
                        {
                          'authorName': bookController.latestBook[index].authorName,
                        },
                        {
                          'categoryName': bookController.latestBook[index].categoryName,
                        },
                        {
                          "book": bookController.latestBook[index],
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
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            imagesUrl + bookController.latestBook[index].bookCoverImg,
                            fit: BoxFit.fill,
                            width: 120.w,
                          ),
                        ),
                        Text(
                          bookController.latestBook[index].bookTitle,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // --------------------------------------------------------------------

        /// ------------------------------ Categories -----------------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
          child: Text(
            'الاقسام',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 50.h,
          child: Obx(
            () => bookController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: blueColor,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: bookController.catList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Category cat = bookController.catList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () async {
                            Get.to(
                              () => CategoryScreen(
                                cat: cat,
                                ctrl: bookController,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                  ? blueLightColor
                                  : mainColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Center(
                                child: Text(
                                  bookController.catList[index].categoryName,
                                  style: TextStyle(
                                    color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                        ? blueDarkColor
                                        : Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        // --------------------------------------------------------------------
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  Widget switchWidget() {
    if (searchController.text.isNotEmpty) {
      return searchWidget();
    } else {
      return mainWidget();
    }
  }
}
