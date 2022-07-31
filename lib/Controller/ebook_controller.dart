// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:welivewithquran/Models/category.dart';
import 'package:welivewithquran/models/ebook_org.dart';
import 'package:welivewithquran/Services/services.dart';

class BookController extends GetxController {
  var bookList = <Ebook>[].obs;
  var latestBook = <Ebook>[].obs;
  var bookMarks = Set<Ebook>().obs;
  var catList = <Category>[].obs;
  var isLoading = true.obs;
  var isPlaying = false.obs;
  var isDownloaded = false.obs;

  @override
  void onInit() {
    getAll();
    getLatest();
    getCats();
    getBookmarks();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<List<Ebook>> _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favs.txt');
      String text = await file.readAsString();
      print(text);
      return fromJsonString(text);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> _save(List<Ebook> books) async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);

    final file = File('${directory.path}/favs.txt');
    final text = json.encode(
      books
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    );
    File saved = await file.writeAsString(text, mode: FileMode.write);
    if (await saved.exists()) {
      print("Saved");
      return true;
    } else {
      return false;
    }
  }

  // Add an Ebook to the favorites
  Future<bool> addEbook(String id) async {
    final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
    bookList[index].inFavorites = true;
    bookMarks.add(bookList[index]);
    bool res = await _save(bookMarks.value.toList());
    return res;
  }

  // Remove an Ebook from the favorites
  Future<bool> removeEbook(String id) async {
    final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
    bookList[index].inFavorites = false;
    bookMarks.removeWhere((Ebook ebook) => ebook.id == id);
    bool res = await _save(bookMarks.value.toList());
    return res;
  }

  Future<void> getBookmarks() async {
    isLoading(true);
    try {
      List<Ebook> list = await _read();
      if (list.isNotEmpty) {
        bookMarks.value = list.toSet();
      }
    } catch (e) {
      //log('Error while getting data is $e');
      bookMarks.value = bookList.value
          .where(
            (Ebook ebook) => ebook.inFavorites == true,
          )
          .toSet();
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAll() async {
    isLoading(true);
    try {
      var ebooks = await DataServices.getEbooks('allbook');
      bookList.value = ebooks!.toList();
    } catch (e) {
      //log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLatest() async {
    isLoading(true);
    try {
      var ebooks = await DataServices.getEbooks('latest');
      latestBook.value = ebooks!.toList();
    } catch (e) {
      //log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCats() async {
    isLoading(true);
    try {
      var cats = await DataServices.getCategories();
      catList.value = cats!.toList();
    } catch (e) {
      //log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
