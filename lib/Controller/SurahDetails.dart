import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurahDetails extends StatelessWidget {
  const SurahDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('eBook'),
      ),
      body: GestureDetector(
          onTap: () => {debugPrint("Clicked")},
          child: Row(
            children: [
              Text(argumentData[0]['title']),
              Text(argumentData[1]['file']),
            ],
          )),
    );
  }
}
