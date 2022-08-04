import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: (ThemeProvider.themeOf(context).id == "dark_theme") ? null : blueDarkColor,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor:
          (ThemeProvider.themeOf(context).id == "dark_theme") ? mainColor : backgroundColor,
      body: Column(
        children: [
          Container(
            height: 220.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color:
                    (ThemeProvider.themeOf(context).id == "dark_theme") ? blueDarkColor : blueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            child: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "لنحيا بالقران",
                      style: TextStyle(
                          fontSize: 20,
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? null
                              : mainColor,
                          fontWeight: FontWeight.w700),
                    ),
                    CustomText(
                      text: "اتصل بنا",
                      fontSize: 24.sp,
                      color: (ThemeProvider.themeOf(context).id == "dark_theme")
                          ? Colors.white
                          : mainColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: (ThemeProvider.themeOf(context).id == "dark_theme")
                    ? blueDarkColor
                    : whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: "وسائل الاتصال",
                    color: (ThemeProvider.themeOf(context).id == "dark_theme")
                        ? whiteColor
                        : blueColor,
                    fontSize: 16.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.email,
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : blueColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "البريد الالكتروني :",
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : blueColor,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "quran@ee.com",
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : blueColor,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.phone_android_outlined,
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? whiteColor
                              : blueColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: "الهاتف المحمول :",
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? whiteColor
                              : blueColor,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: "44006699",
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? whiteColor
                              : blueColor,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.language_outlined,
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : blueColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "موقع الويب :",
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : blueColor,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "Quran-ee.com.kw",
                        color: (ThemeProvider.themeOf(context).id == "dark_theme")
                            ? whiteColor
                            : blueColor,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
                    child: Divider(
                      thickness: 3,
                      color: backgroundColor,
                    ),
                  ),
                  CustomText(
                    text: "لنحيا بالقرآن",
                    color: (ThemeProvider.themeOf(context).id == "dark_theme")
                        ? whiteColor
                        : mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 50.sp,
                  ),
                  CustomText(
                    text: "د. فاطمة بنت عمر نصيف",
                    color: (ThemeProvider.themeOf(context).id == "dark_theme")
                        ? whiteColor
                        : blueLightColor,
                    fontSize: 26.sp,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
