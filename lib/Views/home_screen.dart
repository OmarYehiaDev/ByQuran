import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:welivewithquran/Views/favourite_screen.dart';
import 'package:welivewithquran/Views/library_screen.dart';
import 'package:welivewithquran/Views/main_screen.dart';
import 'package:welivewithquran/Views/settings_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';

import '../custom_widgets/custom_setting_item.dart';
import '../custom_widgets/custom_text.dart';
import '../zTools/helpers.dart';

class HomeScreen extends StatefulWidget {
  final int? index;
  HomeScreen({Key? key, int? this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late int currentIndex;
  PageController _pageController = PageController();
  GlobalKey<DrawerControllerState> drawerKey = GlobalKey<DrawerControllerState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var androidLink = 'https://play.google.com/store/apps/details?id=com.smart.live_by_quran';
  var iOSLink = 'https://apps.apple.com';

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? 0;
    _pageController = PageController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> screen = [
    MainScreen(),
    LibraryScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  checkCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Theme(
        data: ThemeProvider.themeOf(context).data,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            backgroundColor: backgroundColor,

            /// AppBar
            appBar: AppBar(
              elevation: 0,
              backgroundColor: currentIndex == 0
                  ? (ThemeProvider.themeOf(context).id == "dark_theme")
                      ? blueDarkColor
                      : blueBackgroundColor
                  : Colors.transparent,
              toolbarHeight: 85.h,
              title: Text(
                'لنحيا بالقران',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: (ThemeProvider.themeOf(context).id == "dark_theme")
                      ? blueBackgroundColor
                      : mainColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Image.asset(
                    'assets/images/app_bar_icon_new.png',
                    width: 40.w,
                    height: 40.h,
                  ),
                )
              ],
            ),

            /// Drawer
            drawer: Drawer(
              key: drawerKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لنحيا بالقران',
                        style: TextStyle(
                            fontSize: 24.sp, color: mainColor, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: Image.asset(
                          'assets/images/app_bar_icon_new.png',
                          width: 30.h,
                          height: 30.h,
                        ),
                      )
                    ],
                  ),
                  CustomSettingItem(
                    title: 'مشاركة التطبيق',
                    onPress: () {
                      if (Platform.isAndroid)
                        zTools.share(
                          'لنحيا بالقرآن',
                          'لنحيا بالقرآن\n د. فاطمة بنت عمر نصيف',
                          androidLink,
                          'مشاركة: لنحيا بالقرآن',
                        );
                      else if (Platform.isIOS)
                        zTools.share(
                          'لنحيا بالقرآن',
                          'لنحيا بالقرآن\n د. فاطمة بنت عمر نصيف',
                          iOSLink,
                          'مشاركة: لنحيا بالقرآن',
                        );
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Switch(
                            activeColor: blueColor,
                            value: true,
                            onChanged: (value) {},
                          ),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Switch(
                            activeColor: blueColor,
                            value: (ThemeProvider.themeOf(context).id == "dark_theme"),
                            onChanged: (bool val) {
                              val
                                  ? ThemeProvider.controllerOf(context).setTheme("dark_theme")
                                  : ThemeProvider.controllerOf(context).setTheme("light_theme");
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
            ),

            ///BottomNavigationBar
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                unselectedFontSize: 15.sp,
                selectedFontSize: 16.sp,
                onTap: (index) {
                  checkCurrentIndex(index);
                },
                // selectedItemColor: mainColor,

                /// ----------- Bottom Bar Items ------------------------
                items: [
                  BottomNavigationBarItem(
                    label: 'الرئيسية',
                    icon: SvgPicture.asset('assets/icons/main_icon.svg', height: 23),
                    // activeIcon: SvgPicture.asset('assets/icons/explore_colored.svg',
                  ),
                  BottomNavigationBarItem(
                    label: 'المكتبة',
                    icon: SvgPicture.asset('assets/icons/library_icon.svg', height: 23),
                    // activeIcon: SvgPicture.asset('assets/icons/explore_colored.svg',
                  ),
                  const BottomNavigationBarItem(
                    label: 'المفضلة',
                    icon: Icon(
                      Icons.bookmark,
                      color: Color(0xff305F71),
                    ),
                    // activeIcon: SvgPicture.asset('assets/icons/explore_colored.svg',
                  ),
                  const BottomNavigationBarItem(
                    label: 'الاعدادات',
                    icon: Icon(
                      Icons.settings,
                      color: Color(0xff305F71),
                    ),
                    // activeIcon: SvgPicture.asset('assets/icons/explore_colored.svg',
                  ),
                ]),
            // --------------------------------------------------------
            /// Body
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              children: screen,
            ),
          ),
        ),
      ),
    );
  }
}
