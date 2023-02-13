import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:welivewithquran/zTools/colors.dart';

import 'Controller/auth_controller.dart';
import 'Views/splash_screen.dart';
import 'zTools/tools.dart';

Future<void> main() async {
  await dotenv.load();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(dotenv.env["ONESIGNAL_APP_ID"]!);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  // Firebase Initialize
  await Firebase.initializeApp().then(
    (value) async => await Get.put(
      AuthController(),
    ),
  );
  await FirebaseAppCheck.instance.activate();

  // SSL certification problem on all http requests
  HttpOverrides.global = MyHttpOverrides();

  // SharedPreferences pref = await SharedPreferences.getInstance();
  // var email = pref.getString('email');
  await GetStorage.init();
  Get.put(await SharedPreferences.getInstance(), permanent: true);
  await Future.delayed(Duration(seconds: 4));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

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
              // primaryColor: mainColor,
              primaryColor: mainColor,
              fontFamily: 'Janna',
              colorScheme: ColorScheme.light().copyWith(
                background: whiteColor,
              ),
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
