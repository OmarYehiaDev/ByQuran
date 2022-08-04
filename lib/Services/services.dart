import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:welivewithquran/Models/category.dart';
import 'package:welivewithquran/models/ebook_org.dart';
import 'package:welivewithquran/models/search_query.dart' as sea;
import 'package:welivewithquran/models/surah.dart';

String baseUrl = 'https://smartmedia-kw.com/zbook/api.php?';

String baseUrl2 = 'https://smartmedia-kw.com/zbook/';
String api = baseUrl2 + 'api.php?';
String search = baseUrl + "find=";
String category = "cat_id=";
String home = "home";
String surahs = "surah_list";

String imagesUrl = baseUrl2 + 'images/';

class DataServices {
  static Future<List<Ebook>?> getEbooks(query) async {
    String url = baseUrl + query;
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*'
      // 'Content-Type': 'application/json'
      // headers: {'app-id': '6218809df11d1d412af5bac4'}
    });
    if (response.statusCode == 200) {
      ///data successfully
      return fromJson(json.decode(response.body));
    } else {
      ///error
      return null;
    }
  }

  static Future<List<Ebook>?> getFeaturedEbooks() async {
    String url = baseUrl + home;
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*'
      // 'Content-Type': 'application/json'
      // headers: {'app-id': '6218809df11d1d412af5bac4'}
    });
    if (response.statusCode == 200) {
      ///data successfully
      return fromJsonAPI(json.decode(response.body));
    } else {
      ///error
      return null;
    }
  }

  static Future<List<Ebook>?> getEbooksFromCat(String id) async {
    String url = baseUrl + category + id;
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*'
      // 'Content-Type': 'application/json'
      // headers: {'app-id': '6218809df11d1d412af5bac4'}
    });
    if (response.statusCode == 200) {
      ///data successfully
      return fromJson(json.decode(response.body));
    } else {
      ///error
      return null;
    }
  }

  static getAppInfo() async {
    final response = await http.get(Uri.parse(baseUrl),
        headers: {'Accept': 'application/json', 'Access-Control-Allow-Origin': '*'});
    return fromJson(json.decode(response.body));
  }

  static Future<List<sea.SearchQuery>?> searchBooks(String query) async {
    String url = search + query;
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode == 200) {
      ///data successfully
      return sea.fromJsonAPI(json.decode(response.body));
    } else {
      ///error
      return null;
    }
  }

  static Future<List<Category>?> getCategories() async {
    String url = baseUrl + 'cat_list';
    final response = await http.get(Uri.parse(url),
        headers: {'Accept': 'application/json', 'Access-Control-Allow-Origin': '*'});
    if (response.statusCode == 200) {
      ///data successfully
      return fromCatsJson(json.decode(response.body));
    } else {
      ///error
      return null;
    }
  }

  static Future<List<Surah>?> getSurahs() async {
    String url = baseUrl + surahs;
    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json', 'Access-Control-Allow-Origin': '*'},
    );
    if (response.statusCode == 200) {
      ///data successfully
      return fromSurahsJson(json.decode(response.body));
    } else {
      ///error
      return null;
    }
  }
}
