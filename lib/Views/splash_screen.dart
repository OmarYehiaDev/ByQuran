import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:welivewithquran/Views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashTime = 10;
  @override
  void initState() {
    Future.delayed(Duration(seconds: splashTime)).then((value) {
      // Navigator.push( context, MaterialPageRoute( builder: (context) => const NextScreen()));
      Get.off(
        () => LoginScreen(),
        duration: const Duration(milliseconds: 500),

        /// transition: Transition.leftToRightWithFade,
      );
    });
    super.initState();
  }

//   @override
  @override
  Widget build(BuildContext context) {
    //Future.delayed ....
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_image2.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.offAll(() => LoginScreen());
                },
                child: SvgPicture.asset(
                  'assets/icons/splash_button.svg',
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
