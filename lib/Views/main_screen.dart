import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Services/services.dart';

import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BookController bookController = Get.put(BookController());

  List images = [
    'assets/images/sura_image3.png',
    'assets/images/sura_image2.png',
    'assets/images/sura_image3.png',
    'assets/images/sura_image2.png',
    'assets/images/sura_image3.png',
    'assets/images/sura_image2.png',
  ];

  List<Widget> carouselImages = [
    Image.asset('assets/images/sura_image3.png'),
    Image.asset('assets/images/sura_image2.png'),
    Image.asset('assets/images/sura_image3.png'),
    Image.asset('assets/images/sura_image2.png'),
  ];

  int currentPage = 0;
  TextEditingController searchController = TextEditingController();
  String selectedSura = 'الفاتحة';

  List suraList = ['الفاتحة', 'البقرة', 'يوسف', 'الكهف'];

  @override
  Widget build(BuildContext context) {
    final BookController bookController = Get.put(BookController());

    return Obx(
      () => bookController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
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
                              color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: TextFormField(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'أبحث هنا',
                                hintStyle: TextStyle(fontSize: 16.sp, color: mainColor),
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
              Radio(value: false, groupValue: true, onChanged: (value) {}),
              const SizedBox(
                width: 5,
              ),
              CustomText(
                text: 'بحث فى الكل',
                fontSize: 18.sp,
                color: mainColor,
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
              Radio(value: true, groupValue: true, onChanged: (value) {}),
              SizedBox(
                width: 5.w,
              ),
              CustomText(
                text: 'بحث فى الكل',
                fontSize: 18.sp,
                color: mainColor,
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xff305F72), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    //hint:'',
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
                      });
                    },
                    items: suraList.map<DropdownMenuItem<String>>((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(
                          valueItem,
                          style: TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h),
          child: Container(
            height: 40.h,
            width: 190.w,
            decoration: BoxDecoration(color: blueColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: CustomText(
                text: 'بحث',
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  mainWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: SizedBox(
            height: 170.h,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: images.length,
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
                return Center(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
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
              itemCount: images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                  child: CircleAvatar(
                    radius: 8.h,
                    backgroundColor: currentPage == index ? blueBackgroundColor : blueLightColor,
                  ),
                );
              },
            ),
          ),
        ),

        /// ------------------------------ Latest Books -----------------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
          child: Text(
            'المضاف أخيراً',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),
          child: SizedBox(
            height: 280.h,
            child:
                // Get Random eBook API
                ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bookController.latestBook.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          imagesUrl + bookController.latestBook[index].bookCoverImg,
                          fit: BoxFit.fill,
                          height: 190.h,
                          width: 120.w,
                        ),
                      ),
                      Text(
                        bookController.latestBook[index].bookTitle,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
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
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: bookController.catList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 3.0),
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
