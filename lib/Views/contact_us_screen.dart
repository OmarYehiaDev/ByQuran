import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

import '../services/services.dart';

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
              ),
            ),
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
          FutureBuilder<Map<String, String>?>(
            future: DataServices.getAppDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                Map<String, String> data = snapshot.data!;
                return Padding(
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
                              text: "البريد الالكتروني :\n ${data["app_email"]!}",
                              color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                  ? whiteColor
                                  : blueColor,
                              fontSize: 14.sp,
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
                                textDirection: TextDirection.ltr,
                                text: data["app_contact"]!,
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
                              text: "موقع الويب :\n${data["app_website"]!}",
                              color: (ThemeProvider.themeOf(context).id == "dark_theme")
                                  ? whiteColor
                                  : blueColor,
                              fontSize: 14.sp,
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
                          text: data["app_name"]!,
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
                        CustomText(
                          text: "V${data["app_version"]!}",
                          color: (ThemeProvider.themeOf(context).id == "dark_theme")
                              ? whiteColor
                              : blueLightColor,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(color: blueColor),
              );
            },
          ),
        ],
      ),
    );
  }
}
