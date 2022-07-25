import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/zTools/tools.dart';

class ReadBookScreen extends StatefulWidget {
  const ReadBookScreen({Key? key}) : super(key: key);

  @override
  State<ReadBookScreen> createState() => _ReadBookScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _ReadBookScreenState extends State<ReadBookScreen>
    with WidgetsBindingObserver {
  dynamic argumentData = Get.arguments;
  String desc = BookTools.stripHtml(Get.arguments[0]['description']);

  FlutterTts tts = FlutterTts();

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  //bool play = false;

  int end = 0;

  List images = [
    'assets/images/s1.png',
    'assets/images/s2.png',
  ];

  String? _newVoiceText;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override

  /// for Application state
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // inside didChangeAppLifecycle
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        await tts.stop();
        //setState(()=> play = false);
        break;
      case AppLifecycleState.resumed:
        // appLifeCycleState resumed
        break;
      case AppLifecycleState.paused:
        // appLifeCycleState paused
        break;
      case AppLifecycleState.detached:
        // appLifeCycleState detached
        break;
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initTts();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    tts.stop();
    TtsState.stopped;
    super.dispose();
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
    int chars;
    desc.length > 4000 ? chars = 4000 : chars = desc.length;
    setState(() => _newVoiceText = desc.substring(0, chars));
    if (_newVoiceText != null) {
      await tts.awaitSpeakCompletion(true);
      await tts.setQueueMode(1);

      var count = desc.length;
      var max = 2000;
      var loopCount = count ~/ max;
      for (var i = 0; i <= loopCount; i++) {
        if (i != loopCount) {
          await tts.speak(desc.substring(i * max, (i + 1) * max));
        } else {
          var end = (count - ((i * max)) + (i * max));
          await tts.speak(desc.substring(i * max, end));
        }
      }

      tts.setCompletionHandler(() {
        tts.stop();
        //play = false;
      });
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
  Widget build(BuildContext context) {
    // dynamic argumentData = Get.arguments;
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
          BookTools.appName + ' - ' + argumentData[0]['title'],
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
            Text('المولف: ' + argumentData[0]['author']),
            Text(argumentData[0]['pdf']),

            _btnSection(),

            ttsState == TtsState.playing ? _progressBar(end) : const Text(''),

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                //height: MediaQuery.of(context).size.height - 225.h, //550.h
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        fit: BoxFit.fill,
                      );
                    }),
              ),
            ),
            // const SizedBox(height: 7.0),
            //Html( data: (argumentData[0]['description']),),
            //Text(argumentData[0]['pdf']),
            // SizedBox(
            //   child: Text(argumentData[1]['pdf'].toString()), height: 0, width: 0)
          ],
        ),
      ),
    );
  }

  Widget _progressBar(int end) => Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: LinearProgressIndicator(
        minHeight: 4,
        backgroundColor: blueDarkColor,
        valueColor: const AlwaysStoppedAnimation<Color>(blueColor),
        value: end / _newVoiceText!.length,
      ));

  Widget _btnSection() {
    if (isAndroid) {
      return Container(
          height: 60.h,
          width: 130.w,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: blueBackgroundColor),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              width: 42.w,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  icon: const Icon(Icons.play_circle),
                  color: mainColor,
                  // splashColor: Colors.greenAccent,
                  onPressed: () => _speak()),
            ),
            Container(
              width: 42.w,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  icon: const Icon(Icons.stop_circle),
                  color: mainColor,
                  onPressed: _stop),
            ),
            //  IconButton(
            // icon:  SvgPicture.asset('assets/icons/back_arrow.svg'),
            // color: mainColor, onPressed: () => Get.back()),

            // _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_circle, _speak),
            // _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop_circle, _stop),
          ]));
    } else {
      return Container(
          height: 50.h,
          width: 160.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: blueBackgroundColor),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  icon: const Icon(Icons.play_circle),
                  color: mainColor,
                  onPressed: _speak),
            ),
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  icon: const Icon(Icons.pause_circle),
                  color: mainColor,
                  onPressed: _pause),
            ),
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  icon: const Icon(Icons.stop_circle),
                  color: mainColor,
                  onPressed: _stop),
            ),

            // IconButton(
            //     icon: const Icon(Icons.keyboard_backspace),
            //     color: mainColor, onPressed: () => Get.back()),

            // _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_circle, _speak),
            // _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop_circle, _stop),
          ]));
    }
  }
}
