import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:welivewithquran/Controller/ebook_controller.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/zTools/tools.dart';

class ReadBookScreen extends StatelessWidget {
  ReadBookScreen({Key? key}) : super(key: key);

  final FlutterTts tts = FlutterTts();

  final TextEditingController textCtrl = TextEditingController(
      text: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ الرَّحْمَنِ الرَّحِيمِ');

  final BookController eBookCtrl = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;

    tts.setLanguage('ar');
    tts.setSpeechRate(0.4);

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.transparent,
        toolbarHeight: 70.h,
        actions: const [
          // SvgPicture.asset("assets/icons/appbar_icon.svg")
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: backgroundColor, size: 30.h),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          BookTools.appName + ' - ' + argumentData[0]['title'].toString(),
          style: TextStyle(
              fontSize: 24.sp,
              color: backgroundColor,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            //SizedBox(height: 90.h,width: double.infinity,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 60.h,
                width: 200.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffD7F2FC)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          tts.speak(textCtrl.text);
                          //eBookCtrl.isPlaying.value;
                          var result = await tts.speak(textCtrl.text);
                          result == 1
                              ? eBookCtrl.isPlaying.value = true
                              : eBookCtrl.isPlaying.value = false;
                        },
                        child: Container(
                            height: 44.h,
                            width: 48.w,
                            //padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() => eBookCtrl.isPlaying.value
                                ? const Icon(Icons.stop_circle,
                                    color: mainColor)
                                : const Icon(Icons.play_circle,
                                    color: mainColor)))),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        tts.stop();
                        eBookCtrl.isPlaying.value = false;
                      },
                      child: Container(
                        height: 44.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox(
                          child: Icon(Icons.stop_circle, color: mainColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 44.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset('assets/icons/back_arrow.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                //height: MediaQuery.of(context).size.height - 225.h, //550.h
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        'assets/images/book_image.png',
                        fit: BoxFit.fill,
                      );
                    }),
              ),
            ),
            // const SizedBox(height: 7.0),
            Text(argumentData[0]['pdf'].toString()),
            SizedBox(
              child: TextField(controller: textCtrl),
              height: 0,
              width: 0,
            )
          ],
        ),
      ),
    );
  }
}
