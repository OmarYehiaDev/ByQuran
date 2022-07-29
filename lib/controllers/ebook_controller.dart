import 'package:get/get.dart';
import 'package:welivewithquran/Models/category.dart';
import 'package:welivewithquran/Models/ebook.dart';
import 'package:welivewithquran/Services/services.dart';

class BookController extends GetxController {
  var bookList = <Ebook>[].obs;
  var latestBook = <Ebook>[].obs;
  var catList = <Category>[].obs;
  var isLoading = true.obs;
  var isPlaying = false.obs;
  var isDownloaded = false.obs;

  @override
  void onInit() {
    getAll();
    getLatest();
    getCats();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

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
