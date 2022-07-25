import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/zTools/tools.dart';

class ReadBookScreen extends StatefulWidget {
  ReadBookScreen({Key? key}) : super(key: key);

  @override
  State<ReadBookScreen> createState() => _ReadBookScreenState();
}

enum TtsState { playing, stopped, paused, continued }
class _ReadBookScreenState extends State<ReadBookScreen> {

  //====================================================
  late FlutterTts tts;

  // double volume = 0.5;
  // double pitch = 1.0;
  // double rate = 0.5;
  // bool isCurrentLanguageInstalled = false;

  int end = 0;

  String? _newVoiceText = 'الحمد لله رب العالمين';

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    tts = FlutterTts();
    if (isAndroid) {
      _getEngines();
    }

    tts.setStartHandler(() {
      setState(() {
        print('Playing');
        ttsState = TtsState.playing;
      });
    });

    tts.setCompletionHandler(() {
      setState(() {
        print('Complete');
        ttsState = TtsState.stopped;
      });
    });

    tts.setCancelHandler(() {
      setState(() {
        print('Cancel');
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      tts.setPauseHandler(() {
        setState(() {
          print('Paused');
          ttsState = TtsState.paused;
        });
      });

      tts.setContinueHandler(() {
        setState(() {
          print('Continued');
          ttsState = TtsState.continued;
        });
      });
    }

    tts.setErrorHandler((msg) {
      setState(() {
        print('error: $msg');
        ttsState = TtsState.stopped;
      });
    });

    tts.setProgressHandler(
            (String text, int startOffset, int endOffset, String word) {
          setState(() {
            end = endOffset;
          });
        });
  }

  Future _getEngines() async {
    var engines = await tts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _speak() async {
    if (_newVoiceText != null) {
      await tts.awaitSpeakCompletion(true);
      await tts.speak(_newVoiceText!);
    }
  }

  Future _stop() async {
    var result = await tts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await tts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    tts.stop();
  }
  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }
 //====================================================

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
            const Text('الحمد لله ربا العالمين'),
            TextField(
              onChanged: (String value) {
                _onChange(value);
              },
            ),
            ttsState == TtsState.playing ? _progressBar(end) : const Text(''),
            _btnSection(),
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
                    Container(
                        height: 44.h,
                        width: 48.w,
                        //padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.play_circle,
                                color: mainColor)),
                    const SizedBox(width: 10),
                    Container(
                      height: 44.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const SizedBox(
                        child: Icon(Icons.stop_circle,
                            color: mainColor),
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
            const SizedBox(
              child: Text('هلا والله بالحبايب'),
              height: 0,
              width: 0,
            )
          ],
        ),
      ),
    );
  }

  // New Code for tts
  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Widget _progressBar(int end) => Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.red,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        value: end / _newVoiceText!.length,
      ));

  Widget _btnSection() {
    if (isAndroid) {
      return Container(
          padding: const EdgeInsets.only(top: 50.0),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildButtonColumn(Colors.green, Colors.greenAccent,
                Icons.play_arrow, 'PLAY', _speak),
            _buildButtonColumn(
                Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
          ]));
    } else {
      return Container(
          padding: const EdgeInsets.only(top: 50.0),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildButtonColumn(Colors.green, Colors.greenAccent,
                Icons.play_arrow, 'PLAY', _speak),
            _buildButtonColumn(
                Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
            _buildButtonColumn(
                Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
          ]));
    }
  }
}
