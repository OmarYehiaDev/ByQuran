// // state/products.dart
// // ignore_for_file: invalid_use_of_protected_member

// import 'dart:convert';
// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';

// import '../Controller/ebook_controller.dart';
// import '../models/ebook_org.dart';

// class Books extends GetxController {
//   final BookController _controller = Get.put(BookController());
  

//   RxList<Ebook> get _ebooks {
//     return _controller.bookList;
//   }

//   // Use this to retrieve all EBooks
//   List<Ebook> get Ebooks {
//     return _ebooks.value;
//   }

//   // This will return the EBooks that were added to favorites
//   get wishListEbooks async {
//     RxList<Ebook> res = (await _read());
//     if (res.isEmpty) {
//       return _ebooks.where((Ebook ebook) => ebook.inFavorites == true).toList();
//     } else {
//       return res;
//     }
//   }

  // // Add an Ebook to the favorites
  // void addEbook(String id) async {
  //   final int index = _ebooks.indexWhere((Ebook ebook) => ebook.id == id);
  //   _ebooks[index].inFavorites = true;
  //   await _save(wishListEbooks);
  // }

  // // Remove an Ebook from the favorites
  // void removeEbook(String id) async {
  //   final int index = _ebooks.indexWhere((Ebook ebook) => ebook.id == id);
  //   _ebooks[index].inFavorites = false;
  //   await _save(wishListEbooks);
  // }
// }
