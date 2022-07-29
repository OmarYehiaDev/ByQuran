// state/products.dart
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

import 'package:welivewithquran/Models/ebook_org.dart';
import 'package:welivewithquran/services/services.dart';

class Books extends GetxController {
  _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favs.txt');
      String text = await file.readAsString();
      print(text);
      return fromJsonString(text).obs;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  _save(List<Ebook> books) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/favs.txt');
    final text = json.encode(
      books
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    );
    await file.writeAsString(text, mode: FileMode.write);
    print('saved');
  }

  get _ebooks async {
    var ebooks = await DataServices.getEbooks('allbook');
      return ebooks!.toList();
  }

  // Use this to retrieve all EBooks
  List<Ebook> get Ebooks {
    return [..._ebooks as RxList<Ebook>];
  }

  // This will return the EBooks that were added to favorites
  List<Ebook> get wishListEbooks {
    return _ebooks.where((Ebook ebook) => ebook.inFavorites.value == true).toList();
  }

  // Add an Ebook to the favorites
  void addEbook(String id) async {
    final int index = _ebooks.indexWhere((Ebook ebook) => ebook.id == id);
    _ebooks[index].inFavorites.value = true;
    await _save(wishListEbooks);
  }

  // Remove an Ebook from the favorites
  void removeEbook(String id) async {
    final int index = _ebooks.indexWhere((Ebook ebook) => ebook.id == id);
    _ebooks[index].inFavorites.value = false;
    await _save(wishListEbooks);
  }
}
