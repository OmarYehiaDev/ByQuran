import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(TextVoicePage());


class TextVoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextVoice(),
    );
  }
}

class TextVoice extends StatefulWidget {
  @override
  _Speak createState() => _Speak();
}

class _Speak extends State<TextVoice> {
  final FlutterTts flutterTts = FlutterTts();
  ///1
  bool speaking = false;
  late TextEditingController textEditingController;

  @override ///2
  void initState() {
    textEditingController = TextEditingController();
    flutterTts.setStartHandler(() {
      ///This is called when the audio starts
      setState(() {
        speaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      ///This is called when the audio ends
      setState(() {
        speaking = false;
      });
    });
    super.initState();
  }

  @override ///3
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: textEditingController,
                  ),
                ),
              ],
            ),
            SizedBox( ///4
              child: Text(
                  speaking ? "Playing" : "Not playing"
              ),
            )
          ],
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                heroTag: "btn",
                onPressed: () => _speak(textEditingController.text),
                child: Icon(Icons.play_arrow),
              ),
              SizedBox(
                width: 130,
              ),
              FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                heroTag: "btn2",
                onPressed: () => _stop(),
                child: Icon(Icons.stop),
              )
            ],
          ),
        ));
  }

  ///5
  Future _speak(String text) async {
    await flutterTts.setLanguage("es-MX");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Future _stop() async {
    await flutterTts.stop();
  }
}