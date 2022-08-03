import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:welivewithquran/Views/home_screen.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_social_container.dart';

import '../Controller/auth_controller.dart';
import 'sign_up_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 85.h,
          actions: [
            // SvgPicture.asset("assets/icons/appbar_icon.svg"),
          ],
          title: Text(
            'لنحيا بالقران',
            style: TextStyle(
              fontSize: 24.sp,
              color: mainColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFEAF9FF),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 5,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              AuthController.instance.loginAnon();
                              Get.offAll(
                                () => HomeScreen(),
                              );
                            },
                            child: Text(
                              'تخطى',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xff365865),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color(
                          0xff365865,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    /// Login By Facebook
                    CustomSocialContainer(
                      title: 'تسجيل الدخول عبر فيسبوك',
                      containerColor: const Color(0xff507DC0),
                      onTap: () {
                        AuthController.instance.facebookSignIn();
                      },
                    ),

                    /// Login By Twitter
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomSocialContainer(
                        title: 'تسجيل الدخول عبر تويتر',
                        containerColor: const Color(0xff1EA1F1),
                        onTap: () {
                          AuthController.instance.signInWithTwitter();
                        },
                      ),
                    ),

                    /// Login By Google
                    CustomSocialContainer(
                      title: 'تسجيل الدخول عبر جوجل',
                      containerColor: const Color(0xffDC3445),
                      onTap: () {
                        AuthController.instance.googleSignUp();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                      child: Divider(
                        color: Color(0xffA1C3CF),
                        thickness: 2,
                      ),
                    ),

                    /// OR
                    Text(
                      'أو',
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: const Color(
                            0xff365865,
                          ),
                          fontWeight: FontWeight.bold),
                    ),

                    /// Username
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff315F70),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Container(
                                height: 45.h,
                                width: 45.w,
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Color(0xff315F70),
                                ),
                                color: const Color(0xffECEAEB),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'البريد الالكتروني',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff315F70),
                                      fontSize: 14.sp,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///  Password
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff315F70),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 45.h,
                                width: 45.w,
                                child: const Icon(
                                  Icons.lock,
                                  color: Color(0xff315F70),
                                ),
                                color: const Color(0xffECEAEB),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'كلمة المرور',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff315F70),
                                      fontSize: 14.sp,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    CustomSocialContainer(
                      title: 'تسجيل الدخول',
                      containerColor: const Color(0xff315F70),
                      onTap: () {
                        AuthController.instance.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xff315F70),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () => Get.to(
                            () => SignUpPage(),
                          ),
                          child: Text(
                            'سجل الان!',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: const Color(0xff7FB0C1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
