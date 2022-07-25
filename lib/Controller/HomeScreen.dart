import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ebook_controller.dart';
import 'SurahDetails.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final BookController _controller = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eBook'),
      ),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: _controller.bookList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                    child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                )),
                //child: Icon(Icons.picture_as_pdf_sharp),)
                title: Text(
                    "data"), //Html(data: _controller.bookList[index].bookTitle),
                trailing: ElevatedButton(
                    child: const Text("PDF"),
                    onPressed: () {
                      Get.to(() => const SurahDetails(), arguments: [
                        {"title": _controller.bookList[index].bookTitle},
                        {"file": _controller.bookList[index].bookFileUrl},
                      ]);
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
