import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List images = ['f.png', 'g.png', 't.png'];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signup.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.15,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile1.png'),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'البريد الإلكتروني',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.lightBlueAccent,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'كلمة المرور',
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.lightBlueAccent,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: passConfirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'تأكيد كلمة المرور',
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.lightBlueAccent,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (passwordController.text == passConfirmController.text) {
                  AuthController.instance.register(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                } else {
                  Get.snackbar(
                    'About User',
                    'User Message',
                    backgroundColor: Colors.lightBlueAccent,
                    snackPosition: SnackPosition.BOTTOM,
                    titleText: const Text(
                      'حدث خطأ ما..',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.all(16),
                    messageText: Text(
                      "لا تتشابه كلمة المرور مع تأكيد كلمة المرور، برجاء التحقق منهما مرة أخرى وإعادة المحاولة",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                width: w * 0.505,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/login_btn.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    'إنشاء حساب جديد',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            /// لديك حساب
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.back();
                  },
                text: 'لديك حساب ؟',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                ),
              ),
            ),
            SizedBox(
              height: h * 0.09,
            ),
            RichText(
              text: TextSpan(
                text: 'قُم بإنشاء حساب من خلال..',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
              ),
            ),

            /// Google, Facebook
            Wrap(
              children: List<Widget>.generate(
                3,
                (index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        AuthController.instance.facebookSignIn();
                      } else if (index == 1) {
                        AuthController.instance.googleSignUp();
                      } else {
                        AuthController.instance.signInWithTwitter();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blueGrey,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/' + images[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
