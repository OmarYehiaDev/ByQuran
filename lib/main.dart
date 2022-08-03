import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/zTools/colors.dart';

import 'Controller/auth_controller.dart';
import 'Views/splash_screen.dart';
import 'zTools/tools.dart';

Future<void> main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialize
  await Firebase.initializeApp().then(
    (value) async => await Get.put(
      AuthController(),
    ),
  );

  // SSL certification problem on all http requests
  HttpOverrides.global = MyHttpOverrides();

  // SharedPreferences pref = await SharedPreferences.getInstance();
  // var email = pref.getString('email');
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => ThemeProvider(
        loadThemeOnInit: true,
        saveThemesOnChange: true,
        defaultThemeId: "light_theme",
        themes: [
          AppTheme.light().copyWith(
            id: "light_theme",
            data: ThemeData(
              primaryColor: mainColor,
              colorScheme: ColorScheme.light(),
              fontFamily: 'Janna',
            ),
          ),
          AppTheme.dark().copyWith(
            id: "dark_theme",
            data: ThemeData(
              primaryColor: blueDarkColor,
              fontFamily: 'Janna',
              colorScheme: ColorScheme.dark().copyWith(
                secondary: Colors.white,
              ),
            ),
          ),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                // getPages: getPages,
                //initialRoute: RouteConstant.splashScreen,
                title: BookTools.appName,
                theme: ThemeProvider.themeOf(themeContext).data,
                locale: const Locale('ar'),
                home: child!,
              );
            },
          ),
        ),
      ),
      child: SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, String host, int port) => true;
  }
}
