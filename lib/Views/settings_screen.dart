// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/Controller/SettingController.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/Views/contact_us_screen.dart';
import 'package:welivewithquran/Views/downloads_view.dart';
import 'package:welivewithquran/Views/library_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_setting_item.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

import '../Controller/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  //var email = accountData.read();
  final accountData = GetStorage();
  final String email = '';

  final SettingController settingController = GetInstance().put<SettingController>(
    SettingController(),
  );
  final BookController bookController = GetInstance().put<BookController>(
    BookController(),
  );

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    return Container(
      decoration: BoxDecoration(
        color: ThemeProvider.themeOf(context).data.colorScheme.background,
      ),
      child: SingleChildScrollView(
        child: Column(
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
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: CustomText(
                    text: "الإعدادات",
                    fontSize: 30,
                    color: whiteColor,
                  ),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         CustomText(
                  //           text: accountData.read('displayName') ?? 'مستخدم',
                  //           fontSize: 14.sp,
                  //           color: (ThemeProvider.themeOf(context).id == "dark_theme")
                  //               ? blueColor
                  //               : mainColor,
                  //         ),
                  //         CustomText(
                  //           text: accountData.read('email') ?? 'لم تسجل الدخول',
                  //           fontSize: 14.sp,
                  //           color: blueLightColor,
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(width: 24.w),
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         accountData.read('photoUrl') != null
                  //             ? CircleAvatar(
                  //                 child: Image.network(
                  //                   accountData.read(
                  //                     'photoUrl',
                  //                   ),
                  //                 ),
                  //                 maxRadius: 40,
                  //               )
                  //             : CircleAvatar(
                  //                 child: Icon(
                  //                   Icons.person,
                  //                   color: blueColor,
                  //                   size: 40.w,
                  //                 ),
                  //                 backgroundColor: blueBackgroundColor,
                  //                 maxRadius: 30,
                  //               ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
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
                    onPress: () {
                      Get.to(
                        () => Scaffold(
                          extendBodyBehindAppBar: true,
                          body: LibraryScreen(),
                          appBar: AppBar(
                            foregroundColor: (ThemeProvider.themeOf(context).id == "dark_theme")
                                ? null
                                : blueDarkColor,
                            elevation: 0,
                            backgroundColor: (ThemeProvider.themeOf(context).id == "dark_theme")
                                ? blueDarkColor
                                : Colors.transparent,
                          ),
                        ),
                        preventDuplicates: true,
                      );
                    },
                    image: 'assets/icons/library_icon.svg',
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomSettingItem(
                    title: 'التحميلات',
                    onPress: () {
                      Get.to(
                        () => DownloadsScreen(
                          // bookList: bookController.downloadedList.toList(),
                          ctrl: bookController,
                        ),
                      );
                    },
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
                  // user != null && !user.isAnonymous
                  //     ? CustomSettingItem(
                  //         image: 'assets/icons/exit.svg',
                  //         title: 'تسجيل خروج',
                  //         onPress: () {
                  //           logoutDialog(context);
                  //         },
                  //         icon: null,
                  //       )
                  //     : CustomSettingItem(
                  //         image: 'assets/icons/exit.svg',
                  //         title: 'تسجيل دخول',
                  //         onPress: () {
                  //           AuthController.instance.logOut();
                  //         },
                  //         icon: null,
                  //       )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

logoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: blueColor),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(15),
          ),
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
                        horizontal: 20,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                        horizontal: 25,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
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
    },
  );
}
