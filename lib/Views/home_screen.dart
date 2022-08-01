import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:welivewithquran/Views/favourite_screen.dart';
import 'package:welivewithquran/Views/library_screen.dart';
import 'package:welivewithquran/Views/main_screen.dart';
import 'package:welivewithquran/Views/settings_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int currentIndex = 0;
  PageController _pageController = PageController();
  GlobalKey<DrawerControllerState> drawerKey =
      GlobalKey<DrawerControllerState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor,

          /// AppBar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 85.h,
            title: Text(
              'لنحيا بالقران',
              style: TextStyle(
                  fontSize: 24.sp,
                  color: mainColor,
                  fontWeight: FontWeight.w700),
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
            leading: IconButton(
              icon: Icon(Icons.list_outlined, color: mainColor, size: 40.h),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
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
                          fontSize: 24.sp,
                          color: mainColor,
                          fontWeight: FontWeight.w700),
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
                  icon: SvgPicture.asset('assets/icons/main_icon.svg',
                      height: 23),
                  // activeIcon: SvgPicture.asset('assets/icons/explore_colored.svg',
                ),
                BottomNavigationBarItem(
                  label: 'المكتبة',
                  icon: SvgPicture.asset('assets/icons/library_icon.svg',
                      height: 23),
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
    );
  }
}
