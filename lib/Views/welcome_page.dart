import 'package:flutter/material.dart';

import '../Controller/auth_controller.dart';


class WelcomePage extends StatelessWidget {
  final String email;

  const WelcomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage("assets/images/signup.png"),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.15,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/profile1.png"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: w,
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "You Are Welcome",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                AuthController.instance.logOut();
              },
              child: Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/login_btn.png"),
                        fit: BoxFit.fill)),
                child: const Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
