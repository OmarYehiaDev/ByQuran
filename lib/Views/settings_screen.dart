import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/SettingController.dart';
import 'package:welivewithquran/Views/contact_us_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_setting_item.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

import '../Controller/auth_controller.dart';
import '../zTools/helpers.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  //var email = accountData.read();
  final accountData = GetStorage();
  final String email = '';

  final SettingController settingController =
      GetInstance().put<SettingController>(SettingController());

  @override
  Widget build(BuildContext context) {
    // if(accountData.read('email')!= null)
    //   email = accountData.read('email');

    var androidLink =
        'https://play.google.com/store/apps/details?id=com.smart.live_by_quran';
    var iOSLink = 'https://apps.apple.com';
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: accountData.read('displayName') ?? 'مستخدم',
                          fontSize: 14.sp,
                          color: mainColor,
                        ),
                        CustomText(
                          text: accountData.read('email') ?? 'لم تسجل الدخول',
                          fontSize: 14.sp,
                          color: blueLightColor,
                        ),
                      ],
                    ),
                    SizedBox(width: 24.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        accountData.read('photoUrl') != null
                            ? CircleAvatar(
                                child:
                                    Image.network(accountData.read('photoUrl')),
                                maxRadius: 40)
                            : CircleAvatar(
                                child: Icon(Icons.person,
                                    color: blueColor, size: 40.w),
                                backgroundColor: blueBackgroundColor,
                                maxRadius: 30),
                        // Container(
                        //   width: 70.w,
                        //   height: 70.h,
                        //   decoration: BoxDecoration(
                        //     color: blueBackgroundColor,
                        //       borderRadius: BorderRadius.circular(50)
                        //   ),
                        //     child: Icon(Icons.person, color:blueColor ,size: 27.w)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h),

            /// Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  CustomSettingItem(
                    title: 'المكتبة',
                    onPress: () {},
                    image: 'assets/icons/library_icon.svg',
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomSettingItem(
                    title: 'التحميلات',
                    onPress: () {},
                    image: 'assets/icons/down_arrow.svg',
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomSettingItem(
                    title: 'اتصل بنا',
                    onPress: () {
                      Get.to(() => const ContactUsScreen());
                    },
                    image: 'assets/icons/mobile.svg',
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomSettingItem(
                    title: 'مشاركة التطبيق',
                    onPress: () {
                      if (Platform.isAndroid)
                        zTools.share(
                            'لنيحا بابقرآن',
                            'لنحيا بالقرآن\n د. فاطمة بنت عمر نصيف',
                            androidLink,
                            'مشاركة: لنيحا بابقرآن');
                      else if (Platform.isIOS)
                        zTools.share(
                            'لنيحا بابقرآن',
                            'لنحيا بالقرآن\n د. فاطمة بنت عمر نصيف',
                            iOSLink,
                            'مشاركة: لنيحا بابقرآن');
                    },
                    image: 'assets/icons/share.svg',
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Switch(
                              activeColor: blueColor,
                              value: true,
                              onChanged: (value) {}),
                          CustomText(
                            text: 'تفعيل الاشعارات',
                            color: blueColor,
                            fontSize: 17.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Switch(
                            activeColor: blueColor,
                            value: (ThemeProvider.themeOf(context).id ==
                                "dark_theme"),
                            onChanged: (bool val) {
                              val
                                  ? ThemeProvider.controllerOf(context)
                                      .setTheme("dark_theme")
                                  : ThemeProvider.controllerOf(context)
                                      .setTheme("light_theme");
                              // settingController.changeMode();
                            },
                          ),
                          CustomText(
                            text: 'الوضع الليلي',
                            color: blueColor,
                            fontSize: 17.sp,
                          ),
                          // Obx(() => CupertinoSwitch(
                          //     onChanged: (bool _) => settingController.changeMode(),
                          //     value: settingController.isDark.value,
                          //   ),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomSettingItem(
                    image: 'assets/icons/exit.svg',
                    title: 'تسجيل خروج',
                    onPress: () {
                      logoutDialog(context);
                    },
                    icon: null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: blueColor)),
            child: Container(
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(15)),
              height: 140,
              width: 250.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    text: 'هل تريد الخروج من التطبيق ؟',
                    fontSize: 17.sp,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AuthController.instance.logOut();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: CustomText(
                            text: 'نعم',
                            color: blueColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 2),
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: CustomText(
                            text: 'لا',
                            color: blueColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
