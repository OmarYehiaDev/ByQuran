import 'package:welivewithquran/binding/home_binding.dart';
import 'package:welivewithquran/constants/route_constant.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:welivewithquran/Views/splash_screen.dart';


List<GetPage> getPages = [
  GetPage(
      name: RouteConstant.splashScreen,
      page: () =>   SplashScreen(),
      middlewares:  const [
        // Add here AuthGuard(),
      ],
      binding: HomeScreenBinding()),
];