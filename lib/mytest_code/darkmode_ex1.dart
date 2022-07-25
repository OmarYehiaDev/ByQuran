
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Zquare',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.light,
    initialRoute: '/',
    getPages: [
      GetPage(
        name: '/',
        page: () => HomeScreen(),
        transition: Transition.zoom,
      ),
    ],
  ));
}

class SettingController extends GetxController {
  RxBool isDark = false.obs;

  void changeMode() {
    isDark.value = !isDark.value;
    print(isDark.value);
    if (isDark.value) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }
}

class HomeScreen extends StatelessWidget {
  final SettingController settingController =
  GetInstance().put<SettingController>(SettingController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: context.theme.backgroundColor,
        alignment: Alignment.center,
        child: _playBoard(),
      ),
    );
  }

  Center _playBoard() {
    return Center(
      child: Container(
        height: 515,
        width: 515,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Zquare",
                  style: Get.textTheme.headline1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "High score: ",
                      style: Get.textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 60),
            Column(
              children: [
                Container(
                  height: 80,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () => Get.toNamed('/game'),
                    child: Center(
                      child: Text(
                        "Play",
                        style: Get.textTheme.button,
                      ),
                    ),
                  ),
                ),
                Obx(
                      () => CupertinoSwitch(
                    onChanged: (bool _) => settingController.changeMode(),
                    value: settingController.isDark.value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}