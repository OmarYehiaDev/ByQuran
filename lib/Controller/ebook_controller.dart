// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welivewithquran/Models/category.dart';
import 'package:welivewithquran/models/ebook_org.dart';
import 'package:welivewithquran/services/services.dart';
import 'package:share_plus/share_plus.dart';

class BookController extends GetxController {
  final prefs = Get.find<SharedPreferences>();

  var featuredList = <Ebook>[].obs;
  var popularList = <Ebook>[].obs;
  var downloadedList = Set<Ebook>().obs;
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
    getFeatured();
    getPopular();
    getDownloaded();
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
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/favs.txt');
      String text = await file.readAsString();
      print(text);
      return fromJsonString(text);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<int>> getSavedPages(String id) async {
    try {
      final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
      List<String>? res =
          await prefs.getKeys().contains(bookList[index].bookTitle + bookList[index].id + "PAGES")
              ? prefs.getStringList(bookList[index].bookTitle + bookList[index].id + "PAGES")
              : null;

      final pages = res == null
          ? <int>[]
          : res
              .map(
                (e) => int.parse(e),
              )
              .toList();
      log(pages.runtimeType.toString());
      return pages;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> isPageBookmarked(String id, int page) async {
    final pages = await getSavedPages(id);
    return pages.contains(page);
  }

  Future<bool> removeBookmarkPage(String id, int page) async {
    final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
    if (prefs.getKeys().contains(bookList[index].bookTitle + bookList[index].id + "PAGES")) {
      List<int> pages = await getSavedPages(id);
      pages.remove(page);
      await prefs.setStringList(
        bookList[index].bookTitle + bookList[index].id + "PAGES",
        pages.map((e) => e.toString()).toList(),
      );
    }
    final pages = await getSavedPages(id);
    if (!pages.contains(page)) {
      print("Saved");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> bookmarkPage(String id, int page) async {
    final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
    if (prefs.getKeys().contains(bookList[index].bookTitle + bookList[index].id + "PAGES")) {
      List<int> pages = await getSavedPages(id);
      if (!pages.contains(page)) pages.add(page);
      List<String> data = pages.map((e) => e.toString()).toList();
      await prefs.setStringList(
        bookList[index].bookTitle + bookList[index].id + "PAGES",
        data,
      );
    } else {
      List<int> pages = [];
      pages.add(page);
      await prefs.setStringList(
        bookList[index].bookTitle + bookList[index].id + "PAGES",
        pages.map((e) => e.toString()).toList(),
      );
    }
    final pages = await getSavedPages(id);
    if (pages.contains(page)) {
      print("Saved");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _save(List<Ebook> books) async {
    final directory = await getExternalStorageDirectory();
    print(directory!.path);

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
    GetStorage storage = GetStorage();
    final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
    bookList[index].inFavorites = true;
    await storage.write(bookList[index].bookTitle + bookList[index].id, true);
    bookMarks.add(bookList[index]);
    bool res = await _save(bookMarks.value.toList());
    return res;
  }

  // Remove an Ebook from the favorites
  Future<bool> removeEbook(String id) async {
    GetStorage storage = GetStorage();

    final int index = bookList.indexWhere((Ebook ebook) => ebook.id == id);
    bookList[index].inFavorites = false;
    await storage.write(bookList[index].bookTitle + bookList[index].id, false);
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

  Future<void> share(int page, String id) async {
    isLoading(true);
    try {
      var res = await DataServices.getPageImage(page, id);
      await Share.share("تدبر هذه الصفحة:\n $res");
    } catch (e) {
      //log('Error while getting data is $e');
      print('Error while getting data is $e');
      rethrow;
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

  Future<void> getFeatured() async {
    isLoading(true);
    try {
      var ebooks = await DataServices.getFeaturedEbooks();
      featuredList.value = ebooks!.toList();
    } catch (e) {
      log('Error while getting data is $e');
      // print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getPopular() async {
    isLoading(true);
    try {
      var ebooks = await DataServices.getPopularEbooks();
      popularList.value = ebooks!.toList();
    } catch (e) {
      log('Error while getting data is $e');
      // print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getDownloaded() async {
    GetStorage storage = GetStorage();
    isLoading(true);
    List<Ebook> _list = [];
    await getAll();
    try {
      for (Ebook book in bookList.value) {
        bool? isDownloaded = storage.read(book.bookTitle);
        if (isDownloaded != null && isDownloaded) {
          _list.add(book);
        }
      }
      downloadedList.value = _list.toSet();
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
